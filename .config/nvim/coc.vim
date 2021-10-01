
" Coc
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>crn <Plug>(coc-rename)
nmap <leader>cgt <Plug>(coc-type-definition)
nmap <leader>ca :CocAction<CR>
vmap <leader>ca :CocAction<CR>
nmap <leader>cld :CocList diagnostics<CR>
nmap <leader>cls :CocList outline<CR>
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
vmap <leader>cR :CocRestart<CR>
nmap <leader>c. <Plug>(coc-diagnostic-next)
nmap <leader>c, <Plug>(coc-diagnostic-prev)

nmap <silent> cgd <Plug>(coc-definition)
nmap <silent> cgt <Plug>(coc-type-definition)
nmap <silent> cgi <Plug>(coc-implementation)
nmap <silent> csr <Plug>(coc-references)

nnoremap <silent><leader>cst :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

inoremap <silent><expr> <c-l> coc#refresh()
