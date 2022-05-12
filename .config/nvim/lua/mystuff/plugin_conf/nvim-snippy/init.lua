local snippy = require("snippy")
snippy.setup({
    mappings = {
        is = { ["<Tab>"] = "expand_or_advance", ["<S-Tab>"] = "previous" },
        nx = { ["<leader>x"] = "cut_text" },
    },
})

