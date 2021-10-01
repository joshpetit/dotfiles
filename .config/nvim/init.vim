runtime misc.vim
runtime settings.vim
let mapleader=" "
" close tag

" Autoformat

" NERDS
nnoremap <leader>nc :call nerdcommenter#Comment('0',"toggle")<CR>
vnoremap <leader>nc :call nerdcommenter#Comment('x',"toggle")<CR>

nnoremap Q :NERDTreeToggle<CR>
" NERDTree
" Make sure things don't open up inside of nerdtree windows

runtime explugins/git.vim

"Plug
nmap <leader>pi :PlugInstall<CR>
nmap <leader>pu :PlugUpdate<CR>
nmap <leader>pc :PlugClean<CR>

"Make
nmap <leader>mv :Make validate<CR>
nmap <leader>mt :Make types<CR>

runtime explugins/coc.vim
runtime explugins/vimspector.vim

"Vim test
let test#strategy = "dispatch"
nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>

"Float term
nmap <leader>ft :FloatermNew<CR>


" Show the type under the cursor, also gets documentation


" Unicode/emoi stuff
imap <C-E> <Plug>(UnicodeFuzzy)

" Colorizer

" plugins
runtime pluginSettings.vim
runtime plugins.vim


"Goyo
nnoremap <F11> :Goyo<CR>

" AutoFormat stuff
nnoremap <leader>ff :Autoformat<CR>

" Darkmode Popups

nnoremap <leader>w :w<CR>
nnoremap <leader>W :SudoWrite<CR>
" FZF settings
nnoremap <C-f> :FZF<CR>
nnoremap <leader><C-f> :Rg<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>ntf :NERDTreeFind <cWORD><CR>
nnoremap <leader>l <plug>(fzf-complete-line)
"imap <c-L> <plug>(fzf-complete-line)

" Tagbar Settings
nmap <S-T> :TagbarToggle<CR>

" Windowing
" Go through windows easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"leaders
set notimeout
nmap <leader>sv :so ~/.config/nvim/init.vim<CR>
nmap <leader>ss :so Session.vim<CR>
nmap <leader>sz :!source ~/.zshrc<CR>
nnoremap <leader>. :bnext<CR>
nnoremap <leader>, :bprev<CR>
nnoremap <leader>ma :MaximizerToggle<CR>
nnoremap c, :cprev<CR>
nnoremap c. :cnext<CR>
nnoremap <leader>nh :nohl<CR>

" Theme
set background=dark
colorscheme hhpink

" Literally the most ghetto way to source a file
exec 'source ~/.config/nvim/purple.vim'
exec 'source ~/.config/nvim/secret.vim'

nnoremap <Space><Enter> :source ~/.config/nvim/purple.vim<Enter>

"set termguicolors
highlight LineNr ctermfg=grey " Grey unfocused lines
highlight link javaIdentifier NONE

hi Pmenu ctermbg=black ctermfg=white


set numberwidth=1
set ts=2 sw=2
set wildmenu
set scrolloff=8

" Side number
set number
set relativenumber
set scrolloff=8

au BufNewFile,BufRead *.gradle setf groovy

augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END
