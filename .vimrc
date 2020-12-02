set number

"Coc starts disabled
let g:coc_start_at_startup = v:false

" 4 spaces for tabs
set ts=4 sw=4

" Coc rename
nmap <F3> <Plug>(coc-rename)
nnoremap <F2> :NERDTreeToggle<cr>
nmap <F8> :TagbarToggle<CR>
nmap <F4> :make compileJava<bar>copen<CR>
nmap <F5> :!gradle run<CR>
nmap <F12> :tabedit ~/.vimrc<CR>

let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ 'jsx' : 1,
      \ 'tsx' : 1,
      \ 'javascript.jsx' : 1,
      \ 'typescript.tsx' : 1,
      \ 'javascript.tsx' : 1,
      \}

" Dark mode for menus (Coc specifically)
hi Pmenu ctermbg=black ctermfg=white
"
" Taboo remmebers tab names!
set sessionoptions+=tabpages,globals

" Begin vim-plugin
call plug#begin('~/.vim/plugged')


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
Plug 'gcmt/taboo.vim' "Name Tabs!
Plug 'kien/ctrlp.vim' "Ctrl P!
Plug 'davetron5000/java-javadoc-vim' "javadoc?

call plug#end()

let g:dart_style_guide = 2
let g:dart_format_on_save = 1


" Specify a directory for plugins
" " - For Neovim: stdpath('data') . '/plugged'
" " - Avoid using standard Vim directory names like 'plugin'
" call plug#begin('~/.vim/plugged')
"
" " Make sure you use single quotes
"
" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
"
" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
" " Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
" " Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
"
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
"
" " Initialize plugin system
" call plug#end()
"

 "TS REACT
 augroup ReactFiletypes
	     autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
             autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
 augroup END

