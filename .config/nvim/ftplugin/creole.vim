setlocal complete+=k
setlocal dictionary+=~/.config/nvim/data/creole.txt
setlocal iskeyword+=-

nnoremap <buffer><leader>ec :e ~/.config/nvim/data/creole.txt<CR>
