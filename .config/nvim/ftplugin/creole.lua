local map = require('mystuff/mapping_utils')
vim.o.ignorecase = true;
vim.o.infercase = true;
vim.o.spellfile = '/home/joshu/.config/nvim/spell/creole.utf-8.add';
vim.o.dictionary = '/home/joshu/.config/nvim/spell/creole.utf-8.add';
vim.opt_local.complete:append('k');
vim.opt_local.iskeyword:append('-');

map.nmap('<leader>gta',
         '<cmd>!zathura --fork "~/creole/APK.pdf"<CR>')
map.nmap('<leader>gto',
         '<cmd>!zathura --fork "~/creole/ODP.pdf"<CR>')
map.nmap('<leader>gtt',
         '<cmd>!xdg-open "https://translate.google.com/?sl=en&tl=ht&op=translate" & disown<CR>')
map.nmap('<leader>gtS',
         '<cmd>!xdg-open "https://sakai.duke.edu/portal/site/f13ba5c0-825f-40f4-9716-65cfd2b41634" & disown<CR>')
map.nmap('<leader>gtZ',
         '<cmd>!xdg-open "https://duke.zoom.us/j/93281526233" & disown<CR>')

map.nmap('<leader>tc', '<cmd>Translate ht<cr>', {buffer = true})
map.vmap('<leader>tc', '<Esc>:Translate ht<cr>gv', {buffer = true})
map.nmap('<leader>te', '<cmd>Translate en<cr>', {buffer = true})
map.vmap('<leader>te', '<Esc>:Translate en<cr>gv', {buffer = true})
map.imap('<c-e>', 'è', {buffer = true})
map.imap('<c-o>', 'ò', {buffer = true})
