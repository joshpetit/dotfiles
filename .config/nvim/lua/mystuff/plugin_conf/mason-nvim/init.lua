require("mason").setup()
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
    automatic_enable = {
        exclude = { "jdtls", "tsserver" } -- nvim-jdtls thing will enable.
    }
}
)
