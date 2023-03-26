local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = require('mystuff/on_attach_conf')

require("flutter-tools").setup({
    lsp = {
        on_attach = on_attach,
        capabilities = capabilities,
        --- OR you can specify a function to deactivate or change or control how the config is created
        settings = { showTodos = true, completeFunctionCalls = true },
    },
    debugger = {
        enabled = true,
        run_via_dap = true,
        register_configuration = function()
        end,
    },
})
