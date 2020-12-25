set number relativenumber
"Coc starts disabled
let g:coc_start_at_startup = v:false

" 4 spaces for tabs
set ts=4 sw=4
set is "highlight while searching

" add jumps to jump list!
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

"go go go go go
let g:go_doc_url = 'https://pkg.go.dev'
"python formating
autocmd FileType python set sts=4

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'

" make prettier work
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'all'
" prettier run on write
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Coc rename
nmap <F3> <Plug>(coc-rename)
nnoremap <F2> :NERDTreeToggle<cr>
nmap <F8> :TagbarToggle<CR>
nmap <F4> :make compileJava<CR>
nmap <F5> :make run<CR>
nmap <S-F5> :make test<CR>
nmap <S-F12> :tabedit ~/.vimrc<CR>
nmap <F12> :tabedit ~/.vimrc<CR>

autocmd FileType dart nmap<F12> :tabedit pubspec.yaml<CR>
autocmd FileType c nmap<F12> :tabedit makefile<CR>
autocmd FileType java nmap<F12> :tabedit build.gradle<CR>
autocmd FileType dart nmap<F5> :!pub run test<CR>
autocmd FileType c nmap<F4> :make<CR>
autocmd FileType c nmap<F5> :!make && ./%:r.o
autocmd FileType go nmap<F5> :GoRun<CR>
autocmd FileType go nmap<leader>r :!go run % 
autocmd FileType vim nmap<F4> :PlugClean<CR>
autocmd FileType vim nmap<F5> :PlugInstall<CR>
autocmd FileType javascript nmap<F12> :tabedit package.json<CR>
autocmd FileType typescript nmap<F12> :tabedit package.json<CR>

autocmd FileType java :compiler! gradle
set wildignore+=*/build/*
let vim_markdown_preview_hotkey='<C-m>'
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ 'jsx' : 1,
      \ 'tsx' : 1,
      \ 'javascript' : 1,
      \ 'typescript' : 1,
      \}
let test#java#runner = 'gradletest'

" Dark mode for menus (Coc specifically)
hi Pmenu ctermbg=black ctermfg=white
"

" Begin vim-plugin
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go' "Go support!
Plug 'dart-lang/dart-vim-plugin' " Dart support
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'sheerun/vim-polyglot' "Bunch of languages
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'Valloric/MatchTagAlways' "HTML tag highlight
Plug 'preservim/tagbar' "Tag bar
Plug 'aklt/plantuml-syntax' "uml syntax
Plug 'weirongxu/plantuml-previewer.vim' "uml preview
Plug 'tyru/open-browser.vim' "open the browser, for plantuml
Plug 'kien/ctrlp.vim' "Ctrl P!
Plug 'davetron5000/java-javadoc-vim' "javadoc!
Plug 'rustushki/JavaImp.vim' "java imports n stuff
Plug 'vim-test/vim-test' "tests
Plug 'vim-utils/vim-man' "man pages
Plug 'tmhedberg/matchit' "extended %!
Plug 'sukima/xmledit/' "xml extreme! html n jsx too ofc
Plug 'scrooloose/nerdtree-project-plugin' "Nerd tree stuff
Plug 'alvan/vim-closetag' "closing tags
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'vim-scripts/c.vim'
Plug 'tpope/vim-fugitive' "git stuff

call plug#end()


let g:dart_style_guide = 2
let g:dart_format_on_save = 1
" Plug 'junegunn/vim-easy-align'
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" " Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'fatih/vim-go', { 'tag': '*' }
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 augroup ReactFiletypes
	     autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
             autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
 augroup END"
