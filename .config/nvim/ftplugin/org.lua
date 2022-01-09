local m = require('mystuff/mapping_utils')

local o = require('mystuff/option_utils')
o.set_buf_option('textwidth', 80)


m.nmap('gtz', [[<cmd>lua require'mystuff/org'.goToZoom()<CR>]])
m.nmap('gts', [[<cmd>lua require'mystuff/org'.goToSite()<CR>]])
m.nmap('gtn', [[<cmd>lua require'mystuff/org'.goToNotes()<CR>]])
