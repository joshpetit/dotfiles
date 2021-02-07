
" leader keys
	let mapleader=" "
	nnoremap <leader><Space> :
	vnoremap <leader><Space> :
	nnoremap <leader>q :sh<CR>
	nnoremap <leader>, :bp<CR>
	nnoremap <leader>. :bn<CR>
	nnoremap <leader>g :Git<CR>
	nnoremap <leader>G :GrammarousCheck<CR>
	nnoremap <leader>w :w<CR>
	nnoremap <leader><C-f> :Rg<CR>
	nmap <leader>s :so ~/.vimrc<CR>
	nmap <leader>f :Autoformat<CR>
"cl leaders
	augroup cstuff
		autocmd!
		autocmd FileType c :packadd termdebug<CR>
		autocmd FileType c nmap<F7> :Step<CR>
		autocmd FileType c nmap<F8> :Over<CR>
		autocmd FileType c nmap<S-F8> :Over<CR>
		autocmd FileType c nmap<A-F8> :Evaluate
		autocmd FileType c nmap<C-F8> :Break<CR>
		autocmd FileType c nmap<C-S-F8> :Clear<CR>
		autocmd FileType c nmap<F10> :Finish<CR>
	augroup end

"bashl leaders
	augroup bash
		autocmd!
		autocmd FileType sh nmap<leader>r :!./%<CR>
	augroup end

"javal leaders
	augroup	java_cmds
		autocmd!

		autocmd FileType java nmap	<leader>f :FormatCode google-java-format<CR>
		autocmd FileType java :compiler! gradle
		autocmd FileType java nmap<leader>cc :make compileJava<CR>
		autocmd FileType java nmap<leader>ct :make testClasses<CR>
		autocmd FileType java nmap<leader>t :make test<CR>
		autocmd FileType java nmap<leader>b :make build<CR>
		"compiles java test classes
		autocmd FileType java nmap<leader>rr :make run<CR>
		autocmd FileType java nmap<leader>rf :!java %<CR>
		autocmd FileType java nmap<leader>e :split build.gradle<CR>
	augroup end

"dartl leaders
	augroup dart_cmds
		autocmd!

		autocmd FileType dart nmap<leader>l :!dart %<CR>
		autocmd FileType dart nmap<leader>tt :!pub run test<CR>
		autocmd FileType dart nmap<leader>tf :!pub run %<CR>
		autocmd FileType dart nmap<leader>a :FlutterSplit<CR>
		autocmd FileType dart nmap<leader>r :FlutterHotReload<CR>
		autocmd FileType dart nmap<leader>R :FlutterHotRestart<CR>
		autocmd FileType dart nmap<leader>s :FlutterRun<CR>
		autocmd FileType dart nmap<leader>q :FlutterQuit<CR>
		autocmd FileType dart nmap<leader>e :split pubspec.yaml<CR>
		autocmd FileType dart nmap<leader>p :!flutter pub get<CR>
	augroup end

"gol leaders
	augroup go_cmds
		autocmd!

		autocmd FileType go :compiler! gradle
		autocmd FileType go nmap<leader>r :GoRun<CR>
		autocmd FileType go nmap<leader>e :sp go.mod<CR>
		autocmd FileType go nmap<leader>t :GoTest<CR>
		autocmd FileType go nmap<leader>i :GoInstall<CR>
		autocmd FileType go nmap<leader>c :GoTestCompile<CR>
		"run Go with arguments
		autocmd FileType go nmap<leader>a :!go run %
		autocmd FileType go nmap<leader>p :!go get<CR>

		"Debugging
		autocmd FileType go nmap<F2> :GoDebugNext<CR>
		autocmd FileType go nmap<F3> :GoDebugContinue<CR>
		autocmd FileType go nmap<F4> :GoDebugBreakpoint<CR>

		autocmd FileType go nmap<F5> :GoDebugStart<CR>
		autocmd FileType go nmap<F6> :GoDebugStep<CR>
		autocmd FileType go nmap<F7> :GoDebugStepOut<CR>
		autocmd FileType go nmap<F10> :GoDebugStop<CR>
		autocmd FileType go nmap<F12> :GoDebugRestart<CR>
	augroup end

"viml leaders
	augroup vim_cmds
		autocmd FileType vim nmap<leader>u :PlugUpdate<CR>
		autocmd FileType vim nmap<leader>c :so ~/.vimrc <bar> PlugClean<CR>
		autocmd FileType vim nmap<leader>s :so ~/.vimrc<CR>
		autocmd FileType vim nmap<leader>i :so ~/.vimrc <bar> PlugInstall<CR>
	augroup end

"jsl leaders
	augroup	js_mappings
		autocmd!

		autocmd FileType javascript,typescript nmap<leader>e :split package.json<CR>
		autocmd FileType javascript,typescript nmap<leader>s :!yarn start<CR>
		autocmd FileType javascript,typescript nmap<leader>p :!yarn install<CR>
		autocmd FileType javascript,typescript nmap<leader>rr :!yarn run run <CR>
		autocmd FileType javascript,typescript nmap<leader>rf :!node %<CR>
		autocmd FileType javascript,typescript nmap<leader>cc :!yarn run compile<CR>
		autocmd FileType typescript nmap<leader>cf :!tsc %<CR>
	augroup end

"markdown
	augroup mark_mappings
		autocmd!

		autocmd FileType markdown :set dictionary+=/usr/share/dict/words
		autocmd FileType markdown :set complete+=k
	augroup end

"plugin settings
	let g:go_doc_url = 'https://pkg.go.dev'
	let g:go_def_mode='gopls'
	let g:go_info_mode='gopls'
	let g:pydoc_cmd='/usr/bin/pydoc3.8'
	nmap <C-f> :FZF<CR>
	let g:Unicode_no_default_mappings = v:true
	imap <C-E> <Plug>(UnicodeFuzzy)

	let g:dart_style_guide = 2
	let g:dart_format_on_save = 1

	let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'

	"nerdtree
	nnoremap Q :NERDTreeToggle<cr>

	"tagbar
	nmap <S-T> :TagbarToggle<CR>

	"Coc
	let g:coc_start_at_startup = v:false
	nmap <F3> <Plug>(coc-rename)

	"autoformat
	let g:formatters_typescript= ['prettier']
	let g:formatters_typescriptreact = ['prettier']

	let g:pymode_options_colorcolumn = 0
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

	let g:tagbar_type_markdown = {
		\ 'ctagstype': 'markdown',
		\ 'ctagsbin' : '/home/joshu/miscApps/markdown2ctags/markdown2ctags.py',
		\ 'ctagsargs' : '-f - --sort=yes --sro=»',
		\ 'kinds' : [
			\ 's:sections',
			\ 'i:images'
		\ ],
		\ 'sro' : '»',
		\ 'kind2scope' : {
			\ 's' : 'section',
		\ },
		\ 'sort': 0,
	\ }

"plgns
	call plug#begin('~/.vim/plugged')
		Plug 'iamcco/markdown-preview.nvim'
		Plug 'fatih/vim-go' "Go support!
		" Dart support
		Plug 'dart-lang/dart-vim-plugin'
		" flutter stuff
		Plug 'thosakwe/vim-flutter'
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
		Plug 'davetron5000/java-javadoc-vim' "javadoc!
		Plug 'rustushki/JavaImp.vim' "java imports n stuff
		"man pages
		Plug 'vim-utils/vim-man'
		Plug 'tmhedberg/matchit' "extended %!
		Plug 'scrooloose/nerdtree-project-plugin' "Nerd tree stuff
		Plug 'alvan/vim-closetag' "closing tags
		Plug 'prettier/vim-prettier', {
					\ 'do': 'yarn install',
					\ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'yaml', 'html'] }
		Plug 'vim-scripts/c.vim'
		Plug 'tpope/vim-fugitive' "git stuff
		Plug 'junegunn/fzf.vim'
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
		Plug 'chrisbra/unicode.vim'
		"Formatting stuff!
		Plug'Chiel92/vim-autoformat'
		Plug 'fs111/pydoc.vim'
		Plug 'python-mode/python-mode'
		Plug 'ap/vim-css-color'
		Plug 'Dica-Developer/vim-jdb'
		Plug 'tpope/vim-surround'
		Plug 'BurntSushi/ripgrep'
		Plug'google/vim-maktaba'
		Plug 'google/vim-codefmt'
		Plug 'google/vim-glaive'
		Plug 'rhysd/vim-grammarous'
	call plug#end()

	call glaive#Install()
	Glaive codefmt google_java_executable="java -jar /home/joshu/deps/google-java-format-1.9-all-deps.jar"

""general settings
	augroup ReactFiletypes
		autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
		autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
	augroup END


	" add jumps to jump list!
	nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
	nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

	"move windows
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l

	set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk
	set wildignore+=*/.git/*,*/build/*
	" General formatting
	set ts=4 sw=4
	set is "highlight while searching
	set grepprg=rg\ --vimgrep\ --smart-case\ --follow
	hi Pmenu ctermbg=black ctermfg=white
	set number relativenumber
	noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
	noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')


