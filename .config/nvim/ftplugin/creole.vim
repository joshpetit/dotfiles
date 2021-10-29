setlocal complete+=k
setlocal iskeyword+=-
set dictionary=/home/joshu/.config/nvim/spell/creole.utf-8.add
set spellfile=/home/joshu/.config/nvim/spell/creole.utf-8.add
set ignorecase
set infercase

"Go to sakai
nnoremap <leader>gts :!xdg-open https://sakai.duke.edu/portal/site/0c65619d-b84a-4791-8764-9bb710cfe30b/tool/9134bcb5-9fc4-48dc-8dd1-e77db1870021 & disown<CR>
nnoremap <leader>gtS :vsplit ~/creole/docs/syllabus.md<CR>
nnoremap <leader>gtz :!xdg-open https://duke.zoom.us/j/95035654091 & disown<CR>
nnoremap <leader>gta :!zathura --fork "~/creole/books/Ann Pale Kreyol.pdf"<CR>
nnoremap <leader>gtt :!xdg-open "https://translate.google.com/?sl=en&tl=ht&op=translate" & disown<CR>
"Translate creole to engish
let s:cte = "https://translate.google.com/?sl=ht&tl=en&op=translate&text="
"
"Translate english to creole
let s:etc = "https://translate.google.com/?sl=en&tl=ht&text="

fu! TranslateToCreole(text)
  let s:translation = s:etc . a:text
  exe "!xdg-open \"" . s:translation . "\" & disown"
endfunction

fu! TranslateToEnglish(text)
  let s:translation = s:cte . a:text
  exe "!xdg-open \"" . s:translation . "\" & disown"
endfunction

vnoremap <leader>tte :call TranslateToEnglish(GetSelectedText())<CR>
vnoremap <leader>ttc :call TranslateToCreole(GetSelectedText())<CR>
nnoremap <leader>tte :call TranslateToEnglish(expand("<cword>"))<CR>
nnoremap <leader>ttc :call TranslateToCreole(expand("<cword>"))<CR>

nnoremap <leader>ct :execute 'CocCommand translator.popup ' . expand("<cword>")<CR>
vnoremap <leader>ct :execute 'CocCommand translator.popup ' . GetSelectedText()<CR>
nnoremap <leader>clt :CocList translation<CR>

