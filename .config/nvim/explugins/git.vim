nnoremap <leader>gs :Git <bar>normal 4j<CR>
nnoremap <leader>gSS :Git stash<CR>
nnoremap <leader><leader>gs :Git stash<CR>
nnoremap <leader>gSA :Git stash apply<CR>
nnoremap <leader><leader>ga :Git stash apply<CR>
nnoremap <leader>gcb :Git checkout 
nnoremap <leader>gcf :Git checkout %<CR> 
nnoremap <leader>gcl :Git checkout -<CR>
nnoremap <leader>gpl :Git pull<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>glc :Gclog<CR>
nnoremap <leader>gpu :Git push<CR>
nnoremap <leader>gpo :Git push -u origin HEAD<CR>
nnoremap <leader>gfo :Git fetch origin<CR>
nnoremap <leader>gmo :Git merge origin/master<CR>
" Git diff of current file
nnoremap <leader>gdf :Gvdiffsplit<CR>
nnoremap <leader>gb :Merginal<CR>
nnoremap <leader>gB :Git blame<CR>
"Git pull request
nnoremap <leader>gpr :PR<CR>

" Go to a file in fugitive
fu! GitGoFile(file)
  let @/= a:file
  :Git | /
endfunction

nnoremap <leader>gff :call GitGoFile(expand("%"))<CR>

nmap <leader>gf :let @+ = expand("%:p")<cr>
