local o = require('mystuff/option_utils')
local vimp = require('vimp')

vim.cmd([[
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("save") | endif
let R_csv_delim = ','
]]);

vimp.nnoremap('<leader>gte', function()
    vim.cmd([[vim /^\#\+ / %]])
    require('telescope.builtin').quickfix({});
end)



o.set_buf_option('textwidth', 80)
