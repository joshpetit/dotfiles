local lib = require 'nvim-tree.lib'
require('utils')
require('nightfox').load('nightfox', {transparent = true})
vim.notify = require 'notify'

vim.g.mapleader = " "
vim.o.mouse = 'a'
vim.o.relativenumber = true
vim.o.number = true
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
        java = {
            function()
                return {exe = "google-java-format", stdin = true}
            end
        },
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
                return
                    {exe = "raco ", args = {"fmt", "--width 40"}, stdin = true}
            end
        }
    }
}

require'nvim-tree'.setup {
    disable_netrw = false,
    hijack_netrw = false,
    view = {
        mappings = {
            custom_only = false,
            list = {
                {key = {"D"}, cb = "<cmd>lua print(OpenNvimTreeFile())<cr>"}
            }
        }
    }
}

function OpenNvimTreeFile()
    local node = lib.get_node_at_cursor()
    AsyncRun("dragon-drag-and-drop", node.absolute_path)
    print(node.absolute_path)
end

require'nvim-treesitter.configs'.setup {autotag = {enable = true}}

require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}
vim.cmd([[
augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal bufhidden=hide
augroup END
]])

local snippy = require("snippy")
snippy.setup({
    mappings = {
        is = {
            ["<Tab>"] = "expand_or_advance",
            ["<S-Tab>"] = "previous",
        },
        nx = {
            ["<leader>x"] = "cut_text",
        },
    },
})
