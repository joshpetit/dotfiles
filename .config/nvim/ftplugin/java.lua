local m = require('mystuff/mapping_utils')

vim.cmd([[
:iabbrev sout System.out.println
:TSEnable highlight
    ]])

--m.nmap('<leader>ff', '<cmd>FormatCode google-java-format<CR>', {buffer = true})
m.nmap('<leader>dd', '<cmd>CocCommand java.debug.vimspector.start<CR>',
       {buffer = true})
m.nmap('<leader>cc', '<cmd>Make compileJava<CR>', {buffer = true})
m.nmap('<leader>ct', '<cmd>Make testClasses<CR>', {buffer = true})
m.nmap('<leader>t', '<cmd>Make test<CR>', {buffer = true})
m.nmap('<leader>rr', '<cmd>Make run<CR>', {buffer = true})
m.nmap('<leader>rf', '<cmd>!java -ea %<CR>', {buffer = true})
m.nmap('<leader>e', '<cmd>split build.gradle<CR>', {buffer = true})

Jcall(require, "mystuff/secretstuff")
