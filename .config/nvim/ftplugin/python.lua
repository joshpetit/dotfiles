local nmap = function(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true, silent = true})
end

nmap('<leader>rf', '!python %<cr>')
