local m = require('mystuff/mapping_utils')
local o = require('mystuff/option_utils')

m.nmap('<leader>mp', '<cmd>MarkdownPreview<cr>', {buffer = true});
m.cmap('ConvertPdf ', '<cmd>pandoc -i % -o %.pdf<cr>', {buffer = true});
o.set_buf_option('textwidth', 80)
