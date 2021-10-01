nmap <buffer> <leader>rf :!dart %<CR>
nmap <buffer> <leader>tt :!flutter test<CR>
"autocmd FileType dart nma <buffer> p<leader>tf :!pub run %<CR>
nmap <buffer> <leader>rs :CocCommand flutter.dev.hotReload<CR>
nmap <buffer> <leader>R :CocCommand flutter.dev.hotRestart<CR>
nmap <buffer> <leader>ra :CocCommand flutter.run -d Pixel<CR>
nmap <buffer> <leader>rD :CocCommand flutter.dev.detach<CR>
nmap <buffer> <leader>rA :CocCommand flutter.attach<CR>
nmap <buffer> <leader>rd :CocCommand flutter.run -d Pixel -t lib/story.dart<CR>
nmap <buffer> <leader>dL :CocCommand flutter.dev.openDevLog<CR>
nmap <buffer> <leader>rq :CocCommand flutter.dev.quit<CR>
"nmap <buffer> <leader>e :split pubspec.yaml<CR>
nmap <buffer> <leader>p :!flutter pub get<CR>
nnoremap <leader>et :call GoToTestFile(expand('%'))<ENTER>

if exists('GoToTestFile')
  finish
endif

fu! GoToTestFile(file)
  "test/{file_path_rel_lib_without_extension}_test.dart
  let s:file = 'test'.. a:file[3:-6] .. '_test.dart'
  exe ':split ' s:file
endfunction
