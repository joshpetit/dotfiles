require("codecompanion").setup({
    interactions = {
        chat = {
            adapter = "kiro",
            keymaps = {
                clear = false,
            }
        },
        inline = {
            adapter = "kiro",
        },
        cmd = {
            adapter = "kiro",
        },
        background = {
            adapter = {
                name = "kiro",
            },
        },
    },
})
