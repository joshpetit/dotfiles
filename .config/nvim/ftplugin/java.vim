:compiler! gradle
:iabbrev sout System.out.println
nmap <buffer> <leader>ff :FormatCode google-java-format<CR> 
nmap <buffer> <leader>dd :CocCommand java.debug.vimspector.start<CR>
nmap <buffer> <leader>cc :Make compileJava<CR>
nmap <buffer> <leader>ct :Make testClasses<CR>
nmap <buffer> <leader>t :Make test<CR>
nmap <buffer> <leader>rr :Make run<CR>
nmap <buffer> <leader>rf :!java -ea %<CR>
nmap <buffer> <leader>e :split build.gradle<CR>
