local lib = require 'nvim-tree.lib'
require('mystuff/utils')
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

require('neogit').setup {
  disable_commit_confirmation = true,
}

require('formatter').setup {
    filetype = {
        javascript = prettierFormatter,
        javascriptreact = prettierFormatter,
        typescript = prettierFormatter,
        typescriptreact = prettierFormatter,
        markdown = prettierFormatter,
        ['creole.markdown'] = prettierFormatter,
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
                    {exe = "raco ", args = {"fmt", "--width 80"}, stdin = true}
            end
        }
    }
}

require'nvim-tree'.setup {
    disable_netrw = false,
    hijack_netrw = false,
    view = {
        relativenumber = true,
        mappings = {
            custom_only = false,
            list = {
                {key = {"D"}, cb = "<cmd>lua print(OpenNvimTreeFile())<cr>"}
            }
        }
    }
}

require("dapui").setup()

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
        is = {["<Tab>"] = "expand_or_advance", ["<S-Tab>"] = "previous"},
        nx = {["<leader>x"] = "cut_text"}
    }
})

local parser_config = require"nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
    install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'main',
        files = {'src/parser.c', 'src/scanner.cc'}
    },
    filetype = 'org'
}

require'nvim-treesitter.configs'.setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
    highlight = {
        enable = true,
        disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
        additional_vim_regex_highlighting = {'org'} -- Required since TS highlighter doesn't support all syntax features (conceal)
    },
    ensure_installed = {'org'} -- Or run :TSUpdate org
}

require('orgmode').setup({
    org_agenda_files = {'~/sync/org/**/*', '~/sync/org/refile.org'},
    org_default_notes_file = '~/sync/org/refile.org',
    org_deadline_warning_days = 31,
    org_agenda_start_on_weekday = 7,
    org_highlight_latex_and_related = 'native',
    org_agenda_templates = {
        j = {
            description = 'Journal',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            target = '~/sync/org/journal.org'
        },
        p = {
            description = 'Prayer Request',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            target = '~/sync/org/prayers.org'
        },
        e = {
            description = 'Egw book Education',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            target = '~/sync/org/egw-education.org'
        }
    },
    org_custom_expots = {
        z = {
            label = 'Export to RTF format',
            action = function(exporter)
                local current_file = vim.api.nvim_buf_get_name(0)
                local target = vim.fn.fnamemodify(current_file, ':p:r') ..
                                   '.rtf'
                local command = {'pandoc', current_file, '-o', target}
                local on_success = function(output)
                    print('Success!')
                    vim.api.nvim_echo({{table.concat(output, '\n')}}, true, {})
                end
                local on_error = function(err)
                    print('Error!')
                    vim.api.nvim_echo({{table.concat(err, '\n'), 'ErrorMsg'}},
                                      true, {})
                end
                return exporter(command, target, on_success, on_error)
            end
        }
    }
})
vim.cmd([[
    let g:mkdp_filetypes = ['markdown', 'org']
    ]])
