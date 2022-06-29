local lspconfig = require("lspconfig")
-- Setup nvim-cmp.
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            require("snippy").expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-l>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { "i", "s" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    completion = { autocomplete = false },
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- { name = 'vsnip' }, -- For vsnip users.
        -- {name = 'luasnip'}, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        { name = "snippy" }, -- For snippy users.
        { name = "orgmode" },
    }, { { name = "buffer" } }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--
--

local on_attach = require('mystuff/on_attach_conf')

local servers = {
    "tsserver",
    "jdtls",
    "tailwindcss",
    --"r_language_server",
    "gopls",
    "bashls",
    "html"
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
    })
end

require("flutter-tools").setup({
    lsp = {
        on_attach = on_attach,
        capabilities = capabilities,
        --- OR you can specify a function to deactivate or change or control how the config is created
        settings = { showTodos = true, completeFunctionCalls = true },
    },
    -- debugger = {
    --     enabled = true,
    --     run_via_dap = true,
    --     register_configurations = function(_)
    --         local dap = require("dap")
    --         dap.configurations.dart = dap.configurations.dart
    --     end,
    -- },
})

local luaLspConfig = {
    cmd = { "lua-language-server" },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
}

--local luadev = require("lua-dev").setup({lspconfig=luaLspConfig})
local luadev = require("lua-dev").setup({
    lspconfig = {
        on_attach = on_attach,
        capabilities = capabilities,
    },
})

-- require'lspconfig'.sumneko_lua.setup(luaLspConfig)
require("lspconfig").sumneko_lua.setup(luadev)
