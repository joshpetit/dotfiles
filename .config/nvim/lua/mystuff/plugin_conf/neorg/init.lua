require("neorg").setup({
	load = {
		["core.defaults"] = {}, -- Loads default behaviour
		["core.tempus"] = {},
		["core.concealer"] = {}, -- Adds pretty icons to your documents
		["core.integrations.nvim-cmp"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.export"] = {},
		["core.tangle"] = {},
		["core.looking-glass"] = {},
		["core.dirman"] = { -- Manages Neorg workspaces
			config = {
				workspaces = {
					stuff = "~/sync/norg/stuff/",
					programming_notes = "~/sync/norg/programming/"
				},
				default_workspace = "stuff",
			},
		},
		["core.integrations.telescope"] = {},
	},
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.norg" },
	command = "set conceallevel=3",
})

local neorg_callbacks = require("neorg.callbacks")

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
	-- Map all the below keybinds only when the "norg" mode is active
	keybinds.map_event_to_mode("norg", {
		n = { -- Bind keys in normal mode
			{ "<C-s>l", "core.integrations.telescope.find_linkable" },
			{ "<C-s><c-f>", "core.integrations.telescope.search_headings" },
		},

		i = { -- Bind in insert mode
			{ "<C-s>l", "core.integrations.telescope.insert_link" },
		},
	}, {
		silent = true,
		noremap = true,
	})
end)
