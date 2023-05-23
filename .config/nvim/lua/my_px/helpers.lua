local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}
M.get_node_text = function(node)
	return vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf())
end

M.get_winr = vim.api.nvim_get_current_win
M.get_current_node = ts_utils.get_node_at_cursor

return M
