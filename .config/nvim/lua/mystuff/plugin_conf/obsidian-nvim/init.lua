require("obsidian").setup({
	workspaces = {
		{
			name = "wiki",
			path = "~/sync/wiki",
		},
	},
	follow_url_func = function(url)
		vim.fn.setreg("+", url)
		print("Copied: " .. url)
	end,
	completion = {
		nvim_cmp = false,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},
	ui = {
		checkboxes = {
			[" "] = { char = "☐", hl_group = "ObsidianTodo" },
		},
	},
	-- see below for full list of options 👇
})
