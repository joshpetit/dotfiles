local M = {}
local ts_utils = require("nvim-treesitter.ts_utils")

local get_link_text = function()
	local node = ts_utils.get_node_at_cursor()
	local link_text_node = ts_utils.get_named_children(node, "link_text")[1]
	if link_text_node == nil then
		return nil
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local method_node = ts_utils.get_node_at_cursor()
	for id, node in method_query:iter_captures(method_node, bufnr, 0, -1) do
		local name = method_query.captures[id]
		-- P(varText)
		if name == "name" then
			local varText = vim.treesitter.get_node_text(node, bufnr)
			return varText
		end
	end
	return ""
end

M.get_link_text = get_link_text
