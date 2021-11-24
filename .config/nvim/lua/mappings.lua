local nmap = function(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, { noremap = true, silent = true })
end

local imap = function(keys, command)
    vim.api.nvim_set_keymap('i', keys, command, { noremap = true, silent = true })
end

local vmap = function(keys, command)
    vim.api.nvim_set_keymap('v', keys, command, { noremap = true, silent = true })
end

local xmap = function(keys, command)
    vim.api.nvim_set_keymap('v', keys, command, { noremap = true, silent = true })
end

nmap('<S-q>','<cmd>NvimTreeToggle<cr>')
nmap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
nmap ('<leader>sv', '<Cmd>luafile ~/.config/nvim/init.lua<CR>')
nmap('<leader>w','<Cmd>w<CR>')

nmap('<c-f>', '<cmd>Telescope find_files<cr>')
nmap('<leader><c-f>', '<cmd>Telescope live_grep<cr>')
nmap('<leader>fb', '<cmd>Telescope buffers<cr>')
nmap('<leader>fh', '<cmd>Telescope help_tags<cr>')
nmap('q,', '<cmd>cprev<cr>')
nmap('q.', '<cmd>cnext<cr>')
nmap('<c-j>', '<c-w>j')
nmap('<c-k>', '<c-w>k')
nmap('<c-h>', '<c-w>h')
nmap('<c-l>', '<c-w>l')
imap('<c-j>', '<Down>')
imap('<c-k>', '<Up>')
nmap('<leader>ff', 'Format')
