runtime ftplugin/typescript

fu! AddParam() 
  normal "acit
  normal a{newvar}
  let s:var = @a
  :?Props
  :?Props
  normal f{a
  exec "normal a newvar,"
  :/Prop
  exec "normal a newvar,"
endfunction

nnoremap <leader>cva :call AddParam()<CR>
