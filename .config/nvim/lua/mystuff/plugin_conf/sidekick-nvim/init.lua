vim.g.maplocalleader = ""
local sidekick = require("sidekick")
local cli = require("sidekick.cli")

sidekick.setup({
	-- Next edit suggestions need the Copilot LSP, which isn't set up here
	nes = { enabled = false },
	cli = {
		mux = {
			backend = "tmux",
			enabled = true,
		},
	},
})


-- <leader>a is taken by hop, so sidekick lives under <leader>k
vim.keymap.set({ "n", "t", "i", "x" }, "<c-.>", cli.focus, { desc = "Sidekick Focus" })

vim.keymap.set("n", "<leader>kk", cli.toggle, { desc = "Sidekick Toggle CLI" })

vim.keymap.set("n", "<leader>ks", function()
	cli.select({ filter = { installed = true } })
end, { desc = "Sidekick Select CLI" })
vim.keymap.set("n", "<leader>kd", cli.close, { desc = "Sidekick Detach CLI Session" })

vim.keymap.set({ "n", "x" }, "<leader>kt", function()
	cli.send({ msg = "{this}" })
end, { desc = "Sidekick Send This" })

vim.keymap.set("n", "<leader>kf", function()
	cli.send({ msg = "{file}" })
end, { desc = "Sidekick Send File" })

vim.keymap.set("x", "<leader>kv", function()
	cli.send({ msg = "{selection}" })

end, { desc = "Sidekick Send Visual Selection" })

vim.keymap.set({ "n", "x" }, "<leader>kp", cli.prompt, { desc = "Sidekick Select Prompt" })

vim.keymap.set("n", "<leader>kc", function()
	cli.toggle({ name = "claude", focus = true })
end, { desc = "Sidekick Toggle Claude" })
