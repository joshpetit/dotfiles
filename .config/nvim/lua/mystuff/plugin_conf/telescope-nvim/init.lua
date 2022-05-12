require("telescope").setup({
	mappings = {
		i = {
			["<C-Down>"] = require("telescope.actions").cycle_history_next,
			["<C-Up>"] = require("telescope.actions").cycle_history_prev,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
		},
	},
})
