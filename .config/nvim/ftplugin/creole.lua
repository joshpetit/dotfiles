local map = require('mystuff/mapping_utils')
vim.o.ignorecase = true;
vim.o.infercase = true;
vim.o.spellfile = '~/.config/nvim/spell/creole.utf-8.add';
vim.o.dictionary = '~/.config/nvim/spell/creole.utf-8.add';
vim.opt_local.complete:append('k');
vim.opt_local.iskeyword:append('-');

map.nmap('<leader>gts',
         '<cmd>!xdg-open https://sakai.duke.edu/portal/site/0c65619d-b84a-4791-8764-9bb710cfe30b/tool/9134bcb5-9fc4-48dc-8dd1-e77db1870021 & disown<CR>')

map.nmap('<leader>gtz',
         '<cmd>!xdg-open https://duke.zoom.us/j/95035654091 & disown<CR>')
map.nmap('<leader>gta',
         '<cmd>!zathura --fork "~/creole/books/Ann Pale Kreyol.pdf"')
map.nmap('<leader>gtt',
         '<cmd>!xdg-open "https://translate.google.com/?sl=en&tl=ht&op=translate" & disown<CR>')

map.nmap('<leader>ttc', '<cmd>Translate ht<cr>', {buffer = true})
map.vmap('<leader>ttc', '<cmd>Translate ht<cr>', {buffer = true})
map.nmap('<leader>tte', '<cmd>Translate en<cr>', {buffer = true})
map.vmap('<leader>tte', '<cmd>Translate en<cr>', {buffer = true})
