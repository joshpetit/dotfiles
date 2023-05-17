local ts_utils = require("nvim-treesitter.ts_utils")
local null_ls = require("null-ls")

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
	if arg2 ~= nil then
		padding_location = string.format(".%s(%s, %s)", modifier, arg1, arg2)
	else
		padding_location = string.format(".%s(%s)", modifier, arg1)
	end
	vim.api.nvim_buf_set_lines(bufnr, range[3] + 1, range[3] + 1, false, { indentation .. padding_location })
	local winr = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_cursor(winr, { range[3] + 2, padding_location:len() + range[2] - 2 })
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
