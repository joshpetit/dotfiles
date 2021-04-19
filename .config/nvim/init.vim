let mapleader=" "
" Coc
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>cn <Plug>(coc-rename)
inoremap <silent><expr> <c-k> coc#refresh()

" Unicode/emoi stuff
let g:Unicode_no_default_mappings = v:true
imap <C-E> <Plug>(UnicodeFuzzy)

" plugins
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
Plug 'idanarye/vim-merginal' " Git branches and stuff
Plug 'ThePrimeagen/git-worktree.nvim' | Plug 'nvim-lua/plenary.nvim' " worktrees!
Plug 'chrisbra/unicode.vim'
Plug 'tpope/vim-dispatch'
" cs308
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
"cs308 end
Plug 'roggan87/vim-bible'
call plug#end()
"
" Java
augroup	java_cmds
	autocmd!

	autocmd FileType java :compiler! gradle
	autocmd FileType java :iabbrev sout System.out.println
	autocmd FileType java nmap<leader>ff :FormatCode google-java-format<CR>
	autocmd FileType java nmap<leader>cc :Make compileJava<CR>
	autocmd FileType java nmap<leader>ct :Make testClasses<CR>
	autocmd FileType java nmap<leader>t :Make test<CR>
	"compiles java test classes
	autocmd FileType java nmap<leader>rr :Make run<CR>
	autocmd FileType java nmap<leader>rf :!java -ea %<CR>
	autocmd FileType java nmap<leader>e :split build.gradle<CR>
augroup end

augroup md
	autocmd!
	autocmd FileType markdown set textwidth=80
augroup end

" Git
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gb :Merginal<CR>

"Goyo
nnoremap <F11> :Goyo<CR>

" AutoFormat stuff
nnoremap <leader>ff :Autoformat<CR>

" Darkmode Popups
hi Pmenu ctermbg=black ctermfg=white

nnoremap <leader>w :w<CR>

" NERDTree
nnoremap Q :NERDTreeToggle<CR>
" Make sure things don't open up inside of nerdtree windows
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" FZF settings
nnoremap <C-f> :FZF<CR>
nnoremap <leader><C-f> :Rg<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
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
"set termguicolors
highlight LineNr ctermfg=grey " Grey unfocused lines

"let g:enable_italic_font = 1
"let g:hybrid_transparent_background = 1
hi Pmenu ctermbg=black ctermfg=white

"" Random things
"set clipboard+=unnamedplus " yank also goes to clipboard

set numberwidth=1
set ts=2 sw=2
set wildmenu
set scrolloff=8

" Side number
set number
set relativenumber
set scrolloff=8

" Treat line wraps as lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

