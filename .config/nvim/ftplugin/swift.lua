local ts_utils = require("nvim-treesitter.ts_utils")
local null_ls = require("null-ls")

local get_current_node = ts_utils.get_node_at_cursor

local get_node_text = function(node)
	return vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf())
end

local find_next_call_expression = function(node)
	node = node:parent()
	while node ~= nil and node:type() ~= "call_expression" do
		node = node:parent()
	end

	return node
end
local get_entire_call_expression = function()
	local node = ts_utils.get_node_at_cursor()
	local call_expression = find_next_call_expression(node)
	while call_expression:parent():field("target")[1] ~= nil do
		call_expression = find_next_call_expression(call_expression)
	end

	return call_expression
end

local wrap_in_vstack = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local call_expression = get_entire_call_expression()
	local range = { call_expression:range() }
	local indentation = string.rep(" ", range[2])
	local lines = vim.api.nvim_buf_get_lines(bufnr, range[1], range[3] + 1, false)
	local new_indented_lines = {}
	for _, line in pairs(lines) do
		line = "    " .. line
		table.insert(new_indented_lines, line)
	end
	vim.api.nvim_buf_set_lines(bufnr, range[1], range[3] + 1, false, new_indented_lines)
	vim.api.nvim_buf_set_lines(bufnr, range[3] + 1, range[3] + 1, false, { indentation .. "}" })
	vim.api.nvim_buf_set_lines(bufnr, range[1], range[1], false, { indentation .. "VStack {" })
	local winr = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_cursor(winr, { range[1] + 1, range[2] })
end

local add_modifier = function(modifier, arg1, arg2)
	arg1 = arg1 or ""
	local bufnr = vim.api.nvim_get_current_buf()
	local call_expression = get_entire_call_expression()
	local range = { call_expression:range() }
	local indentation = string.rep(" ", range[2])
	local padding_location
	if arg2 ~= nil then
		padding_location = string.format(".%s(%s, %s)", modifier, arg1, arg2)
	else
		padding_location = string.format(".%s(%s)", modifier, arg1)
	end
	vim.api.nvim_buf_set_lines(bufnr, range[3] + 1, range[3] + 1, false, { indentation .. padding_location })
	local winr = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_cursor(winr, { range[3] + 2, padding_location:len() + range[2] - 2 })
end

local get_bufnr = function()
	return vim.api.nvim_get_current_buf()
end

local get_enclosing_struct = function(node)
	node = node:parent()
	while node ~= nil and node:type() ~= "class_declaration" do
		node = node:parent()
	end
	return node
end

local extract_component = function()
	local call_expression = get_entire_call_expression()
	local enclosing_struct = get_enclosing_struct(call_expression)
	local range = { enclosing_struct:range() }
	local call_expression_changes = vim.split(vim.treesitter.get_node_text(call_expression, get_bufnr()), "\n")
	local new_struct_name = vim.fn.input("View name: ")
	local changes = { "", string.format("struct %s: View {", new_struct_name), "  var body: some View {" }

	for _, change in pairs(call_expression_changes) do
		table.insert(changes, change)
	end
	table.insert(changes, "   }")
	table.insert(changes, "}")
	vim.api.nvim_buf_set_lines(get_bufnr(), range[3] + 1, range[3] + 1, false, changes)
	local old_func_range = { call_expression:range() }
	local indentation = string.rep(" ", old_func_range[2])
	vim.api.nvim_buf_set_lines(
		get_bufnr(),
		old_func_range[1],
		old_func_range[3] + 1,
		false,
		{ indentation .. new_struct_name .. "()" }
	)
end

-- Extracts a variable to the struct's fields
local extract_variable_to_struct = function()
	local node = get_current_node()
	local value_argument_node = node
	while value_argument_node ~= nil and value_argument_node:field("value")[1] == nil do
		value_argument_node = value_argument_node:parent()
	end
	local value_node = value_argument_node:field("value")[1]
	local value_node_range = { value_node:range() }
	local line_of_value =
		vim.api.nvim_buf_get_lines(get_bufnr(), value_node_range[1], value_node_range[1] + 1, false)[1]
	vim.pretty_print(line_of_value)
end

vim.keymap.set("n", "<leader><leader>w", wrap_in_vstack)

vim.keymap.set("n", "<leader><leader>apt", function()
	add_modifier("padding", ".top", 4)
end)

vim.keymap.set("n", "<leader><leader>apb", function()
	add_modifier("padding", ".bottom", 4)
end)

vim.keymap.set("n", "<leader><leader>apl", function()
	add_modifier("padding", ".left", 4)
end)

vim.keymap.set("n", "<leader><leader>apr", function()
	add_modifier("padding", ".right", 4)
end)

vim.keymap.set("n", "<leader><leader>af", function()
	add_modifier("font", ".")
end)

vim.keymap.set("n", "<leader><leader>ec", function()
	extract_component()
end)

vim.keymap.set("n", "<leader><leader>ev", function()
	extract_variable_to_struct()
end)

if not null_ls.is_registered("swift-actions") then
	require("null-ls").register({
		name = "swift-actions",
		method = { require("null-ls").methods.CODE_ACTION },
		filetypes = { "swift" },
		generator = {
			fn = function()
				return {
					{
						title = "Add padding",
						action = function()
							add_modifier("padding", ".top", 4)
						end,
					},
				}
			end,
		},
	})

	require("null-ls").register({
		name = "swift-actions",
		method = { require("null-ls").methods.CODE_ACTION },
		filetypes = { "swift" },
		generator = {
			fn = function()
				return {
					{
						title = "Add font",
						action = function()
							add_modifier("font", ".headline")
						end,
					},
				}
			end,
		},
	})
end
