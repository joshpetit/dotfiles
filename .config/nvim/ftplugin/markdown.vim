set textwidth=80
nmap <buffer><silent> <leader>pi :call mdip#MarkdownClipboardImage()<CR>
nmap <buffer><silent> <leader>mp :MarkdownPreview<CR>
command ConvertPdf :!pandoc -i % -o %.pdf
command OpenPdf :!zathura --fork %.pdf
