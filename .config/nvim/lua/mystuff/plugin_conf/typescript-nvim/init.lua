local on_attach = require('mystuff/on_attach_conf')
require("typescript").setup({
    server = {
        on_attach = on_attach
    }
})
