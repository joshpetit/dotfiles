local ts_utils = require("nvim-treesitter.ts_utils")


local find_next_call_expression = function(node)
    node = node:parent()
    while node ~= nil and node:type() ~= "call_expression" do
        node = node:parent()
    end

    return node
end

local wrap_in_vstack = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local node = ts_utils.get_node_at_cursor()
    local call_expression = find_next_call_expression(node)
    while call_expression:parent():field("target")[1] ~= nil do
        call_expression = find_next_call_expression(call_expression)
    end
    local range = { call_expression:range() }
    local indentation = string.rep(" ", range[2])
    local lines = vim.api.nvim_buf_get_lines(bufnr, range[1], range[3] + 1, false)
    vim.pretty_print(lines[1])
    local new_indented_lines = {}
    for _, line in pairs(lines) do
        line = "    " .. line
        table.insert(new_indented_lines, line)
    end
    vim.api.nvim_buf_set_lines(bufnr, range[1], range[3] + 1, false, new_indented_lines)
    vim.api.nvim_buf_set_lines(bufnr, range[3] + 1, range[3] + 1, false, {indentation .. "}"})
    vim.api.nvim_buf_set_lines(bufnr, range[1], range[1], false, {indentation .. "VStack {"})
    local winr = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(winr, {range[1] + 1, range[2]})
    -- vim.pretty_print(vim.treesitter.get_node_text(call_expression, bufnr))
end



vim.keymap.set("n", "<leader><leader>w", wrap_in_vstack)
