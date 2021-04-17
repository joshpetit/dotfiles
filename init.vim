call plug#begin(stdpath('data') . '/plugged')
Plug 'iamcco/markdown-preview.nvim' " Preview markdown
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompleten what not
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter' " Side git status
Plug 'preservim/tagbar' "Tag bar
Plug 'tpope/vim-fugitive' " Git stuff
Plug 'junegunn/fzf.vim' " Ayyye fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

set clipboard+=unnamedplus

set numberwidth=1
set wildmenu

" Side number
set number
set relativenumber

" Treat line wraps as lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Darkmode Popups
hi Pmenu ctermbg=black ctermfg=white

let mapleader=" "
nnoremap <leader>w :w<CR>

nnoremap Q :NERDTreeToggle<CR>

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
