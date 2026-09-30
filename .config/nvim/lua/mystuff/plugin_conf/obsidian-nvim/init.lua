require("obsidian").setup({
    picker = {
        name = "snacks.picker"
    },
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
	attachments = {
		folder = "assets/imgs",
        img_text_func = function(path)
            local base = vim.fn.expand("~/sync/wiki")
            local relative_path = vim.fs.relpath(base, tostring(path))
            local file_name = vim.fs.basename(tostring(path))
            return string.format("![%s](<%s>)", file_name, relative_path)
        end,
        img_name_func = function()
          return string.format("pasted_image_%s", os.date "%Y%m%d%H%M%S")
        end,
		confirm_img_paste = false,
	},

	daily_notes = {
		folder = "dailies",
	},
	-- ui = {
	-- 	checkboxes = {
	-- 		[" "] = { char = "☐", hl_group = "ObsidianTodo" },
	-- 	},
	-- },
})
