runtime misc.vim
let mapleader=" "
" close tag
 let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.tsx"


" Autoformat
let g:formatters_typescriptreact = ['prettier']
let g:formatters_typescript= ['eslint_local']
"let g:autoformat_verbosemode = 1


" NERDS
nnoremap <leader>nc :call nerdcommenter#Comment('0',"toggle")<CR>
vnoremap <leader>nc :call nerdcommenter#Comment('x',"toggle")<CR>

let g:NERDCreateDefaultMappings = 0
nnoremap Q :NERDTreeToggle<CR>
" NERDTree
" Make sure things don't open up inside of nerdtree windows
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Git
nnoremap <leader>gs :Git <bar>normal 4j<CR>
nnoremap <leader>gSS :Git stash<CR>
nnoremap <leader>gSA :Git stash apply<CR>
nnoremap <leader>gcb :Git checkout 
nnoremap <leader>gcl :Git checkout -<CR>
nnoremap <leader>gpl :Git pull<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>glc :Gclog<CR>
nnoremap <leader>gpu :Git push<CR>
nnoremap <leader>gpo :Git push -u origin HEAD<CR>
nnoremap <leader>gfo :Git fetch origin<CR>
nnoremap <leader>gmo :Git merge origin/master<CR>
" Git diff of current file
nnoremap <leader>gdf :Gvdiffsplit<CR>
nnoremap <leader>gb :Merginal<CR>

" Go to a file in fugitive
fu! GitGoFile(file)
  let @/= a:file
  :Git | /
endfunction

nnoremap <leader>ggf :call GitGoFile(expand("%"))<CR>

nmap <leader>gf :let @+ = expand("%:p")<cr>

"Plug
nmap <leader>pi :PlugInstall<CR>
nmap <leader>pu :PlugUpdate<CR>
nmap <leader>pc :PlugClean<CR>

"Make
nmap <leader>mv :Make validate<CR>
nmap <leader>mt :Make types<CR>
" Coc
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>crn <Plug>(coc-rename)
nmap <leader>cgt <Plug>(coc-type-definition)
nmap <leader>ca :CocAction<CR>
vmap <leader>ca :CocAction<CR>
nmap <leader>cld :CocList diagnostics<CR>
nmap <leader>cls :CocList outline<CR>
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
vmap <leader>cR :CocRestart<CR>
nmap <leader>c. <Plug>(coc-diagnostic-next)
nmap <leader>c, <Plug>(coc-diagnostic-prev)

nmap <silent> cgd <Plug>(coc-definition)
nmap <silent> cgt <Plug>(coc-type-definition)
nmap <silent> cgi <Plug>(coc-implementation)
nmap <silent> csr <Plug>(coc-references)

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

"Vim test
let test#strategy = "dispatch"
nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>

"Float term
nmap <leader>ft :FloatermNew<CR>


let g:disable_no_maps = 1
inoremap <silent><expr> <c-k> coc#refresh()

" Show the type under the cursor, also gets documentation
nnoremap <silent><leader>cst :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

"nnoremap <nowait><expr> <C-j> coc#float#has_float() ? "<Down>" : "\<C-f>"
"nnoremap <nowait><expr> <C-k> coc#float#has_float() ? "<Up>" : "\<C-f>"

" Unicode/emoi stuff
let g:Unicode_no_default_mappings = v:true
imap <C-E> <Plug>(UnicodeFuzzy)

" Colorizer
let g:colorizer_auto_filetype='qf'
let g:colorizer_disable_bufleave = 1

" plugins
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

call plug#end()



" Java
"
augroup cs230
  autocmd!
  autocmd FileType scheme vmap<leader>rs :w !racket<CR>
  autocmd FileType scheme nmap<leader>rf :!racket %<CR>
  autocmd FileType scheme :set filetype=racket
augroup end
augroup	java_cmds
	autocmd!

	autocmd FileType java :compiler! gradle
	autocmd FileType java :iabbrev sout System.out.println
	autocmd FileType java nmap<leader>ff :FormatCode google-java-format<CR>
	autocmd FileType java nmap<leader>dd :CocCommand java.debug.vimspector.start<CR>
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
	autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
augroup end

augroup bash
	autocmd!
	autocmd FileType sh nmap<leader>rr :!./%<CR>
	autocmd FileType sh nmap<leader>ra :!./% 
augroup end

augroup pyjunk
	autocmd!
	autocmd FileType python nmap<leader>rf :!python3.9 %<CR>
	autocmd FileType python nmap<leader>tt :!pytest<CR>
	autocmd FileType python nmap<leader>tf :!pytest %<CR>
augroup end

augroup dart_cmds
	autocmd!

	autocmd FileType dart nmap<leader>rf :!dart %<CR>
	autocmd FileType dart nmap<leader>tt :!flutter test<CR>
	"autocmd FileType dart nmap<leader>tf :!pub run %<CR>
	autocmd FileType dart nmap<leader>rs :CocCommand flutter.dev.hotReload<CR>
	autocmd FileType dart nmap<leader>R :CocCommand flutter.dev.hotRestart<CR>
	autocmd FileType dart nmap<leader>ra :CocCommand flutter.run -d Pixel<CR>
	autocmd FileType dart nmap<leader>rD :CocCommand flutter.dev.detach<CR>
	autocmd FileType dart nmap<leader>rA :CocCommand flutter.attach<CR>
	autocmd FileType dart nmap<leader>rd :CocCommand flutter.run -d Pixel -t lib/story.dart<CR>
	autocmd FileType dart nmap<leader>dL :CocCommand flutter.dev.openDevLog<CR>
	autocmd FileType dart nmap<leader>rq :CocCommand flutter.dev.quit<CR>
	autocmd FileType dart nmap<leader>e :split pubspec.yaml<CR>
	autocmd FileType dart nmap<leader>p :!flutter pub get<CR>
augroup end

augroup typescript_cmds
	autocmd!

	autocmd FileType typescript nmap<leader>rf :!ts-node %<CR>
	autocmd FileType typescript nmap<leader>tf :CocCommand jest.fileTest<CR>
	autocmd FileType typescript nmap<leader>ts :CocCommand jest.singleTest<CR>
	autocmd FileType typescript nmap<leader>tt :CocCommand jest.projectTest<CR>

	autocmd FileType typescriptreact nmap<leader>tf :CocCommand jest.fileTest<CR>
	autocmd FileType typescriptreact nmap<leader>ts :CocCommand jest.singleTest<CR>
	autocmd FileType typescriptreact nmap<leader>tt :CocCommand jest.projectTest<CR>
augroup end


"Goyo
nnoremap <F11> :Goyo<CR>

" AutoFormat stuff
nnoremap <leader>ff :Autoformat<CR>
let g:python3_host_prog="/bin/python"

" Darkmode Popups

nnoremap <leader>w :w<CR>
nnoremap <leader>W :SudoWrite<CR>
" FZF settings
nnoremap <C-f> :FZF<CR>
nnoremap <leader><C-f> :Rg<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>l <plug>(fzf-complete-line)
imap <c-L> <plug>(fzf-complete-line)
let g:fzf_history_dir='~/.config/fzf_history'

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
