inoremap <C-Q> <ESC>:wq<CR>
"
" Remove leading whitespace
nnoremap <S-Tab> ^d0
" run with...
vnoremap <leader>rw :w !

"copy file path
nmap cp :let @+ = expand("%")<cr>
nmap <leader>cp :let @+ = expand("%:p")<cr>
nmap <leader>q :
inoremap <C-Backspace> <C-w>

" Open certain buffers
nnoremap <leader>ev :e ~/.config/nvim/init.vim<ENTER>
nnoremap <leader>eu :UltiSnipsEdit<ENTER>

nnoremap <leader>ef :e<ENTER>


" Navigaiton in command mode
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" Treat line wraps as lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

inoremap <C-j> <Down>
inoremap <C-k> <Up>

fu! GetIp()
    "let s:ip = !ip route get 1.2.3.4 | awk '{print $7}'
endfunction

":call GetIp()
