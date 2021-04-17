call plug#begin(stdpath('data') . '/plugged')
Plug 'iamcco/markdown-preview.nvim' " Preview markdown
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
call plug#end()

" Git
nnoremap <leader>gs :Git<CR>

"Goyo
nnoremap <F11> :Goyo<CR>

" AutoFormat stuff
nnoremap <leader>ff :Autoformat<CR>


" Darkmode Popups
hi Pmenu ctermbg=black ctermfg=white

let mapleader=" "
nnoremap <leader>w :w<CR>

" NERDTree
nnoremap Q :NERDTreeToggle<CR>
" Make sure things don't open up inside of nerdtree windows
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" FZF settings
nnoremap <C-f> :FZF<CR>
nnoremap <leader><C-f> :Rg<CR>
nnoremap <leader>l <plug>(fzf-complete-line)

" Tagbar Settings
nmap <S-T> :TagbarToggle<CR>

" QuickFix junk
function! s:build_quickfix_list(lines)
	call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
	copen
	cc
endfunction

let g:fzf_action = {
			\ 'ctrl-q': function('s:build_quickfix_list'),
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-v': 'vsplit'}

" Windowing
" Go through windows easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Generic Leaders
nmap <leader>sv :so ~/.config/nvim/init.vim<CR>

" Theme
set background=dark
colorscheme hhpink

let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
hi Pmenu ctermbg=black ctermfg=white



"" Random things
"set clipboard+=unnamedplus

set numberwidth=1
set wildmenu

" Side number
set number
set relativenumber

" Treat line wraps as lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
