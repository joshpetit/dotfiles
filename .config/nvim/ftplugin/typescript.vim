nmap <buffer> <leader>rf :!ts-node %<CR>
nmap <buffer> <leader>tf :CocCommand jest.fileTest<CR>
nmap <buffer> <leader>ts :CocCommand jest.singleTest<CR>
nmap <buffer> <leader>tt :CocCommand jest.projectTest<CR>
nnoremap <leader>et :call GoToTestFile(expand('%'))<ENTER>

if exists('GoToTestFile')
  finish
endif

fu! GoToTestFile(file)
  "test/{file_path_rel_lib_without_extension}_test.dart
  let s:file = 'test'.. a:file[3:-4] .. '.test.ts'
  exe ':split ' s:file
endfunction
