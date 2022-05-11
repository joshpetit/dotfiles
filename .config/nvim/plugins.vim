
call plug#begin(stdpath('data') . '/plugged')
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompleten what not
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'PhilRunninger/nerdtree-visual-selection' |
            \ Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'airblade/vim-gitgutter' " Side git status
Plug 'preservim/tagbar' "Tag bar
Plug 'tpope/vim-fugitive' " Git stuff
Plug 'junegunn/fzf.vim' " Ayyye fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'Chiel92/vim-autoformat'
Plug 'sheerun/vim-polyglot' " Syntax highlighting
Plug 'flazz/vim-colorschemes' " color scheme bundles
Plug 'junegunn/goyo.vim' " Focus! Good for writing
Plug 'idanarye/vim-merginal' " Git branches and stuff
Plug 'chrisbra/unicode.vim'
Plug 'tpope/vim-dispatch'
" cs308
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
"cs308 end
Plug 'tpope/vim-eunuch' " SudoWrite!
Plug 'ap/vim-css-color'
Plug 'ferrine/md-img-paste.vim'
Plug 'chrisbra/Colorizer'
Plug 'puremourning/vimspector' " Learn later
Plug 'szw/vim-maximizer'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/groovyindent-unix'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-abolish'
Plug 'delphinus/vim-firestore'
Plug 'DougBeney/pickachu'
Plug 'wlangstroth/vim-racket'
Plug 'voldikss/vim-floaterm'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdcommenter'
"Plug 'MicahElliott/vrod'
Plug 'axvr/zepl.vim'
Plug 'supermomonga/neocomplete-source-javafx-css.vim'
Plug 'tpope/vim-rhubarb'
Plug 'kristijanhusak/vim-create-pr'
Plug 'bogado/file-line'
Plug 'codegram/vim-codereview'
Plug 'lervag/vimtex'
Plug 'mboughaba/i3config.vim'
Plug 'brooth/far.vim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()



" QuickFix junk
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit'}
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

func! DragnDrop()
    exe "!dragon-drag-and-drop " . g:NERDTreeFileNode.GetSelected().path.str()  . " & disown"
endfunc
" THIS IS HOW YOU CAN GET INPUT IN VIM!!!
"let command = input('Command: ') . ' ' . g:NERDTreeFileNode.GetSelected().path.str()

