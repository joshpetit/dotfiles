require("codecompanion").setup({
    interactions = {
        chat = {
            adapter = "kiro",
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
