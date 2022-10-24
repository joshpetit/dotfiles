local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = require('mystuff/on_attach_conf')

local servers = {
    "tsserver",
    "jdtls",
    "vuels",
    "tailwindcss",
    "gopls",
    "bashls",
    "html",
    "awk_ls",
    "perlnavigator",
    "pyright",
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
local luadev = require("neodev").setup({
    lspconfig = {
        on_attach = on_attach,
        capabilities = capabilities,
    },
})

-- require'lspconfig'.sumneko_lua.setup(luaLspConfig)
require("lspconfig").sumneko_lua.setup(luaLspConfig)
