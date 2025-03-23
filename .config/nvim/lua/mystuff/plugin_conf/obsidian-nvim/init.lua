local settings = require("mystuff.settings")

require("obsidian").setup({
	workspaces = {
		{
			name = "wiki",
			path = "~/sync/wiki",
		},
		{
			name = "Controversia Prophetica",
			path = "~/sync/obsidian/Controversia Prophetica/",
		},
	},
	follow_url_func = function(url)
		vim.ui.open(url)
	end,
	completion = {
		nvim_cmp = false,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},
	daily_notes = {
		folder = "dailies",
	},
	ui = {
		checkboxes = {
			[" "] = { char = "☐", hl_group = "ObsidianTodo" },
		},
	},
	-- see below for full list of options 👇
})
