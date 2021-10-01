let g:fzf_history_dir='~/.config/fzf_history'


let g:python3_host_prog="/bin/python"

let g:colorizer_auto_filetype='qf'

"let g:autoformat_verbosemode = 1

let g:colorizer_disable_bufleave = 1

let g:disable_no_maps = 1

let g:Unicode_no_default_mappings = v:true
let g:NERDCreateDefaultMappings = 0

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.tsx"

" Autoformat
let g:formatters_typescriptreact = ['prettier']
let g:formatters_typescript= ['prettier']

if filereadable(".eslintrc.js")
    let g:formatters_typescript= ['eslint_local']
    echo "SpecificFile exists"
endif


autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif