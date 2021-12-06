local m = require('mystuff/mapping_utils')
vim.cmd([[
 vmap <buffer> <leader>rs :w !racket<CR>
 nmap <buffer> <leader>rf :!racket %<CR>
 nmap <buffer> <leader>rl :exe "ReplSend" "(load \"" ..expand("%").."\")"<CR>
 :set filetype=racket
 ]])


