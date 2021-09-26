" Spector
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dt :call vimspector#LaunchWithSettings(#{configuration: 'debugTest'})<CR>

"Exit spector
nmap <leader>de :call vimspector#Reset()<CR>
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dwa :VimspectorWatch <C-R><C-W><CR>
nmap <leader>dsa <Plug>VimspectorBalloonEval

nmap <leader>dR <Plug>VimspectorRestart
nmap <leader>dc :call vimspector#Continue()<CR>
nmap <leader>db <Plug>VimspectorToggleBreakpoint
nmap <leader>dB <Plug>VimspectorToggleConditionalBreakpoint
