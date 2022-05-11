M = {}

M.set_option = function(option, value)
    vim.api.nvim_set_option(option, value)
end

M.set_buf_option = function(option, value)
    vim.api.nvim_buf_set_option(vim.api.nvim_get_current_buf(), option, value)
end

-- Add a g:var variable
M.set_g = function(option, value)
    vim.api.nvim_set_var(option, value)
end
return M;
