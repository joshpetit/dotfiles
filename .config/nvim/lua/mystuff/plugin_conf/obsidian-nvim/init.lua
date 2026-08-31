require("obsidian").setup({
    legacy_commands = false,
	workspaces = {
		{
			name = "wiki",
			path = "~/sync/wiki",
		},
		-- {
		-- 	name = "Controversia Prophetica",
		-- 	path = "~/sync/obsidian/Controversia Prophetica/",
		-- },
	},
	completion = {
		min_chars = 2,
	},
    daily_notes = {
        folder = "dailies"
    },
	-- ui = {
	-- 	checkboxes = {
	-- 		[" "] = { char = "☐", hl_group = "ObsidianTodo" },
	-- 	},
	-- },
	-- see below for full list of options 👇
})
