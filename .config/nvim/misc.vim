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
nnoremap <leader>sf /\c
nnoremap <leader>sb ?\c


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

fu! LastFile(currFile)
    let s:curr = a:currFile
    while @% == a:currFile
        :normal <CR>
    endwhile
endfunction

nnoremap <leader>o :call LastFile(expand("%"))<CR>
"nnoremap <C-O> :call LastFile(expand("%"))<CR>
"
func! GetSelectedText()
  normal gv"xy
  let result = getreg("x")
  normal gv
  return result
endfunc

func! GetIp()
  let s:thing = system("ip route get 1.2.3.4 | awk '{print $7}' | head -n 1")
  return s:thing[0:-2]
endfunc

inoremap <C-R>I <C-R>=GetIp()<C-M>
":call GetIp()


