let g:colors_name = "purple"

let s:primary = 147
let s:primary_darker = 146
let s:unimportant = 102
let s:primary_weird = 111
let s:primary_light = 117
let s:cooldude = 159
exe 'hi Constant ctermfg='s:primary_weird
exe 'hi Comment ctermfg='s:unimportant
exe 'hi Number ctermfg='s:primary_darker
exe 'hi Identifier ctermfg='s:primary_light
exe 'hi Statement ctermfg='s:primary
exe 'hi PreProc ctermfg='s:primary_light
exe 'hi Include ctermfg='s:primary_light
exe 'hi Type ctermfg='s:primary
exe 'hi Special ctermfg='s:cooldude
exe 'hi Error ctermbg='s:primary_darker
exe 'hi Error ctermfg=black'
exe 'hi Todo ctermbg='s:primary

