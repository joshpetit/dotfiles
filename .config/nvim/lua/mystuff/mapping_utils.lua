M = {}

M.nmap = function(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true, silent = true})
end

M.cmap = function(keys, command)
    vim.api.nvim_set_keymap('c', keys, command, {noremap = true, silent = true})
end

M.imap = function(keys, command)
    vim.api.nvim_set_keymap('i', keys, command, {noremap = true, silent = true})
end

M.vmap = function(keys, command)
    vim.api.nvim_set_keymap('v', keys, command, {noremap = true, silent = true})
end

M.xmap = function(keys, command)
    vim.api.nvim_set_keymap('x', keys, command, {noremap = true, silent = true})
end

return M
