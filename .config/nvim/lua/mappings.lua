local nmap = function(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true, silent = true})
end

local cmap = function(keys, command)
    vim.api.nvim_set_keymap('c', keys, command, {noremap = true, silent = true})
end

local imap = function(keys, command)
    vim.api.nvim_set_keymap('i', keys, command, {noremap = true, silent = true})
end

local vmap = function(keys, command)
    vim.api.nvim_set_keymap('v', keys, command, {noremap = true, silent = true})
end

local xmap = function(keys, command)
    vim.api.nvim_set_keymap('x', keys, command, {noremap = true, silent = true})
end

nmap('<S-q>', '<cmd>NvimTreeToggle<cr>')
nmap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
-- nmap ('<leader>sv', '<Cmd>luafile ~/.config/nvim/init.lua<CR>')
nmap('<leader>w', '<Cmd>w<CR>')
nmap('<leader>gs', '<Cmd>Neogit<CR>')
nmap('<leader><c-f>', '<cmd>Telescope live_grep<cr>')
nmap('<leader>fb', '<cmd>Telescope buffers<cr>')
nmap('<leader>fh', '<cmd>Telescope help_tags<cr>')
nmap('q,', '<cmd>cprev<cr>')
nmap('q.', '<cmd>cnext<cr>')
nmap('<leader>nf', '<cmd>NvimTreeFindFileToggle<cr>')
nmap('<leader>ff', '<cmd>Format<CR>')

nmap('<c-j>', '<c-w>j')
nmap('<c-k>', '<c-w>k')
nmap('<c-h>', '<c-w>h')
nmap('<c-l>', '<c-w>l')
cmap('<c-j>', '<Down>')
cmap('<c-k>', '<Up>')

nmap('<leader>sf', '/\\c')
nmap('<leader>sb', '?\\c')
nmap('<leader>th', '<cmd>TOhtml<CR>')
nmap('<leader>ta', '<cmd>TOhtml<CR>')
nmap('<leader>tz', '<cmd>TOhtml<CR>')
nmap('<leader>tb', '<cmd>TOhtml<CR>')
nmap('<leader>tn', '<cmd>TOhtml<CR>')
nmap('<leader>nh', '<cmd>noh<CR>')
nmap('<leader>nc', '<cmd>CommentToggle<CR>')

nmap('<leader>sv', '<cmd>:lua require("telescopic").reload()<CR>')
nmap('<c-f>', '<cmd>:lua require("telescopic").cooler()<CR>')

-- Git mappings
nmap('<leader>gmo', '<cmd>!git merge origin/master<CR>')
nmap('<leader>gpo', '<cmd>!git push -u origin HEAD<CR>')
nmap('<leader>gpu', '<cmd>!git push origin HEAD<CR>')
nmap('<leader>gpl', '<cmd>!git pull<CR>')
