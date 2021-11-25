require('nightfox').load('nightfox', {transparent = true})
vim.g.mapleader = " "

-- Formatters
--
local prettierFormatter = {
    -- prettier
    function()
        return {
            exe = "prettier",
            args = {
                "--stdin-filepath",
                vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                '--single-quote'
            },
            stdin = true
        }
    end
}

require('formatter').setup {
    filetype = {
        javascript = prettierFormatter,
        javascriptreact = prettierFormatter,
        typescript = prettierFormatter,
        typescriptreact = prettierFormatter,
        lua = {
            -- luafmt
            function() return {exe = "lua-format", stdin = true} end
        },
        dart = {
            -- Shell Script Formatter
            function()
                return {exe = "dart", args = {"format"}, stdin = true}
            end
        },
        racket = {
            -- Shell Script Formatter
            function()
                return {exe = "raco ", args = {"fmt", "--width 40"}, stdin = true}
            end
        }
    }
}
