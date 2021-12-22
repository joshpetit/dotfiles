local lspconfig = require('lspconfig')
-- Setup nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-l>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-j>'] = cmp.mapping(function()
            if cmp.visible() then cmp.select_next_item() end
        end, {"i", "s"}),
        ["<C-k>"] = cmp.mapping(function()
            if cmp.visible() then cmp.select_prev_item() end
        end, {"i", "s"}),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    completion = {autocomplete = false},
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, -- { name = 'vsnip' }, -- For vsnip users.
        -- {name = 'luasnip'}, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        {name = 'snippy'}, -- For snippy users.
        {name = 'orgmode'}
    }, {{name = 'buffer'}})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--
--

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    require"lsp_signature".on_attach()

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap = true, silent = true}

    buf_set_keymap('n', '<leader>cgD', '<cmd>lua vim.lsp.buf.declaration()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>cgd', '<cmd>lua vim.lsp.buf.definition()<CR>',
                   opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>cgi',
                   '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>cst',
                   '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>cgt',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>crn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
    -- opts)
    buf_set_keymap('n', '<leader>ca',
                   '<cmd>lua require("telescope.builtin").lsp_code_actions()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>csr', '<cmd>lua vim.lsp.buf.references()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>csd',
                   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>c,',
                   '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<leader>c.',
                   '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>cld', '<cmd>Telescope diagnostics<CR>', opts)
    -- LSP formatting unreliable
    -- buf_set_keymap('n', '<leader>ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('v', '<leader>ca',
                   '<Cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup {}

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)
end

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {capabilities = capabilities, on_attach = on_attach}

    server:setup(opts)
end)

local servers = {'tsserver', 'jdtls', 'tailwindcss'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
    }
end

-- imap('<c-j>','<Down>')

require("flutter-tools").setup {
    lsp = {
        on_attach = on_attach,
        capabilities = capabilities,
        --- OR you can specify a function to deactivate or change or control how the config is created
        settings = {showTodos = true, completeFunctionCalls = true}
    }
}

local luaLspConfig = {
    cmd = {'lua-language-server'},
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}

local luadev = require("lua-dev").setup({lspconfig = luaLspConfig})

require'lspconfig'.sumneko_lua.setup(luaLspConfig)
-- require'lspconfig'.sumneko_lua.setup(luadev)
