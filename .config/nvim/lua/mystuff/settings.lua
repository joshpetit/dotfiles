require("mystuff/utils")
local M = {}

vim.o.timeout = false
vim.g.mapleader = " "
vim.o.mouse = "a"
vim.o.relativenumber = true
vim.o.number = true
-- vim.opt.statuscolumn = "%l %r"

vim.o.scrolloff = 8
vim.o.tabstop = 4
vim.opt_local.cindent = true
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.termguicolors = true
--vim.cmd('abbrev %% expand("%")')

vim.cmd([[
let test#strategy = "dispatch"
let g:vim_markdown_folding_disabled = 1
]])
-- Formatters
--
vim.cmd([[
    let g:mkdp_filetypes = ['markdown', 'org']
    ]])

vim.cmd([[
"aug CSV_Editing
"		au!
"		au FileType csv :%ArrangeColumn
"aug end
]])

vim.cmd([[
function! g:LatexPasteImage(relpath)
    execute "normal! i\\includegraphics{" . a:relpath . "}\r\\caption{I"
    let ipos = getcurpos()
    execute "normal! a" . "mage}"
    call setpos('.', ipos)
    execute "normal! ve\<C-g>"
endfunction
autocmd FileType tex let g:PasteImageFunction = 'g:LatexPasteImage'
autocmd FileType markdown,tex nmap <buffer><silent> <leader>mp :call mdip#MarkdownClipboardImage()<CR>
]])

vim.cmd([[
au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
]])

vim.cmd([[
let g:vimtex_view_method = 'zathura'
]])

return M
