return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	init = function()
		vim.wo.conceallevel = 2
	end,
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	completion = {
		nvim_cmp = false,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},
	-- ui = {
	-- 	checkboxes = {
	-- 		[" "] = { char = ">", hl_group = "ObsidianTodo" },
	-- 	},
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "wiki",
				path = "~/sync/wiki",
			},
		},

		-- see below for full list of options 👇
	},
}
