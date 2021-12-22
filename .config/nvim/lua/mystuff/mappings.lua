local m = require('mystuff/mapping_utils')

m.nmap('<S-q>', '<cmd>NvimTreeToggle<cr>')
m.nmap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
-- nmap ('<leader>sv', '<Cmd>luafile ~/.config/nvim/init.lua<CR>')
m.nmap('<leader>w', '<Cmd>w<CR>')
m.nmap('<leader>gs', '<Cmd>Neogit<CR>')
m.nmap('<leader><c-f>', '<cmd>Telescope live_grep<cr>')
m.nmap('<leader>fb', '<cmd>Telescope buffers<cr>')
m.nmap('<leader>fh', '<cmd>Telescope help_tags<cr>')
m.nmap('q,', '<cmd>cprev<cr>')
m.nmap('q.', '<cmd>cnext<cr>')
m.nmap('<leader>nf', '<cmd>NvimTreeFindFileToggle<cr>')
m.nmap('<leader>ff', '<cmd>Format<CR>')

m.nmap('<c-j>', '<c-w>j')
m.nmap('<c-k>', '<c-w>k')
m.nmap('<c-h>', '<c-w>h')
m.nmap('<c-l>', '<c-w>l')
m.cmap('<c-j>', '<Down>')
m.cmap('<c-k>', '<Up>')

m.nmap('<leader>sf', '/\\c')
m.nmap('<leader>sb', '?\\c')
m.nmap('<leader>th', '<cmd>TOhtml<CR>')
m.nmap('<leader>ta', '<cmd>TOhtml<CR>')
m.nmap('<leader>tz', '<cmd>TOhtml<CR>')
m.nmap('<leader>tb', '<cmd>TOhtml<CR>')
m.nmap('<leader>tn', '<cmd>TOhtml<CR>')
m.nmap('<leader>nh', '<cmd>noh<CR>')
m.nmap('<leader>nc', '<cmd>CommentToggle<CR>')

--m.nmap('<leader>sv', '<cmd>:lua require("mystuff/telescopic").reload()<CR>')
m.nmap('<c-f>', '<cmd>:lua require("mystuff/telescopic").cooler()<CR>')

m.nmap('<leader>gmo', '<cmd>!git merge origin/master<CR>')
m.nmap('<leader>gpo', '<cmd>!git push -u origin HEAD<CR>')
m.nmap('<leader>gpu', '<cmd>!git push origin HEAD<CR>')
m.nmap('<leader>gpl', '<cmd>!git pull<CR>')
m.nmap('<leader>gb', '<cmd>Git blame<CR>')
m.nmap('<leader>ev', '<cmd>e ~/.config/nvim/init.lua<ENTER>')
m.nmap('<leader>cls', '<cmd>SymbolsOutline<cr>')
m.nmap('<F11>', '<cmd>TZAtaraxis<cr>')
-- m.nmap("<leader>nc", "<Plug>kommentary_jine_default")
-- m.vmap("<leader>nc", "<Plug>kommentary_visual_default")
--
function _G.ReloadConfig()
    local hls_status = vim.v.hlsearch
    for name,_ in pairs(package.loaded) do
        if name:match('^mystuff') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    if hls_status == 0 then
        vim.opt.hlsearch = false
    end
    print('sup')
end

m.nmap('<leader>rv', '<cmd>lua ReloadConfig()<cr>')
vim.cmd('command! ReloadConfig lua ReloadConfig()')