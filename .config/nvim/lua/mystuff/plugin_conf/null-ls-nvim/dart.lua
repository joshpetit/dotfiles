local m = {}
local ts_utils = require("nvim-treesitter.ts_utils")

local class_variables_query = vim.treesitter.parse_query(
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
	while node ~= nil and node:type() ~= "type_identifier" do
		node = node:prev_sibling()
	end
	return node
end

local get_class_variables = function(class_node)
	local variables = {}
	for id, node in class_variables_query:iter_captures(class_node, bufnr, 0, -1) do
		local name = class_variables_query.captures[id]
		if name == "class_field" then
			table.insert(variables, node)
		end
	end
    return variables
end

M.create_to_string = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local root = get_parent_class_node()
	local root_range = { root:range() }
	local changes = { "String toString() {", 'return """' }
	for id, node in class_variables_query:iter_captures(root, bufnr, 0, -1) do
		local name = class_variables_query.captures[id]
		if name == "class_field" then
			local range = { node:range() }
			local varText = vim.treesitter.get_node_text(node, bufnr)
			local typeText = vim.treesitter.get_node_text(get_type_of_variable(node), bufnr)
			table.insert(changes, string.format("%s: $%s", varText, varText))
		end
	end
	table.insert(changes, '""";')
	table.insert(changes, "}")
	vim.api.nvim_buf_set_lines(bufnr, root_range[3], root_range[3], false, changes)
end

M.create_from_json = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local root = get_parent_class_node()
	local root_range = { root:range() }
	local class_name = vim.treesitter.get_node_text(root, bufnr)

	local constructor_definition = string.format("%s.fromJson(Map<String, dynamic> json)", class_name)
    local variables = get_class_variables(root)
	local changes = { constructor_definition, " : this(" }

    vim.pretty_print(variables)
	table.insert(changes, ");")
end

return M
