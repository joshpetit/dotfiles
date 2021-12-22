local m = require('mystuff/mapping_utils')

m.nmap('<leader>rf', '<cmd>!ts-node %<cr>', {buffer = true})
m.nmap('<leader>tf', '<cmd>CocCommand jest.fileTest<cr>', {buffer = true})
m.nmap('<leader>ts', '<cmd>CocCommand jest.singleTest<cr>', {buffer = true})
m.nmap('<leader>tt', '<cmd>CocCommand jest.projectTest<cr>', {buffer = true})
m.nmap('<leader>da', '<cmd>lua require("mystuff/debug").node()<cr>',
       {buffer = true})
-- m.nmap('t', '<cmd>call GoToTestFile(expand(' % '))<ENTER>', {buffer = true})

-- fu! GoToTestFile(file)
--  "test/{file_path_rel_lib_without_extension}_test.dart
--  let s:file = 'test'.. a:file[3:-4] .. '.test.ts'
--  exe ':split ' s:file
-- endfunction
