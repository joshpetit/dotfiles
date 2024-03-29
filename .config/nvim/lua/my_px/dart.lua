local M = {}
local ts_utils = require("nvim-treesitter.ts_utils")

-- I could make this a map and set the handler function to create the fromJson thing
-- I can set all of these to the same.

local parse_json_primitive_field = function(opt)
	local type = opt.type
	local field_name = opt.field_name
	return string.format("json['%s']", field_name)
end


local parse_json_object_field = function(opt)
	local type = opt.type
	local field_name = opt.field_name
	return string.format("%s.fromJson(json['%s'])", type, field_name)
end

local default_convertible_raw = {
	List = parse_json_primitive_field,
	String = parse_json_primitive_field,
	int = parse_json_primitive_field,
	double = parse_json_primitive_field,
}


local serialize_json_primitive_field = function(opt)
	local type = opt.type
	local field_name = opt.field_name
	return string.format('%s', field_name)
end
local serialize_json_object_field = function(opt)
	local type = opt.type
	local field_name = opt.field_name
	return string.format("%s.toJson()", field_name)
end

local default_serializable_raw = {
	List = serialize_json_primitive_field,
	String = serialize_json_primitive_field,
	int = serialize_json_primitive_field,
	double = serialize_json_primitive_field,
}
local class_variables_query = vim.treesitter.query.parse(
	"dart",
	[[
(declaration
  (initialized_identifier_list) @class_field
  )
]]
)

local get_parent_class_node = function()
	local node = ts_utils.get_node_at_cursor()
	while node ~= nil and node:type() ~= "class_definition" do
		node = node:parent()
	end
	return node
end

local get_type_of_variable = function(node)
	local bufnr = vim.api.nvim_get_current_buf()
	while node ~= nil and node:type() ~= "type_identifier" do
		node = node:prev_sibling()
	end
	return vim.treesitter.get_node_text(node, bufnr)
end

local get_class_variables = function(class_node)
	local variables = {}
	local bufnr = vim.api.nvim_get_current_buf()
	for id, node in class_variables_query:iter_captures(class_node, bufnr, 0, -1) do
		local name = class_variables_query.captures[id]
		if name == "class_field" then
			table.insert(variables, node)
		end
	end
	return variables
end

local create_to_string = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local root = get_parent_class_node()
	local root_range = { root:range() }
	local changes = { "String toString() {", 'return """' }
	for id, node in class_variables_query:iter_captures(root, bufnr, 0, -1) do
		local name = class_variables_query.captures[id]
		if name == "class_field" then
			local range = { node:range() }
			local varText = vim.treesitter.get_node_text(node, bufnr)
			local typeText = get_type_of_variable(node)
			table.insert(changes, string.format("%s: $%s", varText, varText))
		end
	end
	table.insert(changes, '""";')
	table.insert(changes, "}")
	vim.api.nvim_buf_set_lines(bufnr, root_range[3], root_range[3], false, changes)
end

local has_parent_class_node = function()
	local root = get_parent_class_node()
	return root ~= nil
end

local create_from_json = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local root = get_parent_class_node()
	local root_range = { root:range() }
	local class_name = vim.treesitter.get_node_text(root:child(1), bufnr)
	local constructor_definition = string.format("  %s.fromJson(Map<String, dynamic> json)", class_name)
	local indentation = string.rep(" ", 6)
	local changes = { "", constructor_definition, indentation .. ": this(" }
	local variables = get_class_variables(root)

	local var_indentation = string.rep(" ", 10)
	for index, node in pairs(variables) do
		local type = get_type_of_variable(node)
		local variable = vim.treesitter.get_node_text(node, bufnr)
		local valueParser = default_convertible_raw[type] or parse_json_object_field
		local value = valueParser({ type = type, field_name = variable })
		local bananas = string.format(var_indentation .. "%s: %s,", variable, value)
		table.insert(changes, bananas)
	end
	table.insert(changes, string.rep(" ", 8) .. ");")
	-- vim.pretty_print(changes)
	vim.api.nvim_buf_set_lines(bufnr, root_range[3], root_range[3], false, changes)

	local winr = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_cursor(winr, { root_range[3] + 2, root_range[4] + 1 })
end

local wrap_in_kdebug = function()
	vim.cmd([[normal! Oif (kDebugMode) {jo}]])
end

local create_to_json = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local root = get_parent_class_node()
	if root == nil then
		return
	end
	local root_range = { root:range() }
	local method_signature = string.format("  Map<String, dynamic> toJson() => {")
	local indentation = string.rep(" ", 4)
	local changes = { "", method_signature }
	local variables = get_class_variables(root)

	local var_indentation = string.rep(" ", 10)
	for _, node in pairs(variables) do
		local type = get_type_of_variable(node)
		local variable = vim.treesitter.get_node_text(node, bufnr)
		local valueParser = default_serializable_raw[type] or serialize_json_object_field
		local value = valueParser({ type = type, field_name = variable })
		local bananas = string.format(var_indentation .. '"%s": %s,', variable, value)
		table.insert(changes, bananas)
	end
	table.insert(changes, string.rep(" ", 2) .. "};")
	-- vim.pretty_print(changes)
	vim.api.nvim_buf_set_lines(bufnr, root_range[3], root_range[3], false, changes)

	local winr = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_cursor(winr, { root_range[3] + 2, root_range[4] + 1 })
end

M.create_to_json = function()
	if not has_parent_class_node() then
		return nil
	end

	return {
		title = "Add toJson",
		action = create_to_json,
	}
end


M.create_to_string = function()
	if not has_parent_class_node() then
		return nil
	end

	return {
		title = "Add toString",
		action = create_to_string,
	}
end

M.create_from_json = function()
	if not has_parent_class_node() then
		return nil
	end
	return {
		title = "Add fromJson",
		action = create_from_json,
	}
end

M.wrap_in_kdebug = function()
	return {
		title = "Wrap in kdebug",
		action = wrap_in_kdebug,
	}
end
return M
