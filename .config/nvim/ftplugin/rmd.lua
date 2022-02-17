local o = require('mystuff/option_utils')

vim.cmd([[
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("save") | endif
let R_csv_delim = ','
]]);


o.set_buf_option('textwidth', 80)
