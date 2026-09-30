require("nvim-treesitter.configs").setup({
	sync_install = false,
	highlight = {
        additional_vim_regex_highlighting = { "markdown" },
		enable = true,
	},
    indent = {
        enable = true,
    },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<leader>k",
			node_incremental = "<leader>k",
			scope_incremental = "<leader>K",
			node_decremental = "<leader>j",
		},
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		local parsers = require("nvim-treesitter.parsers")

		parsers.puml = {
			install_info = {
				url = "https://github.com/ahlinc/tree-sitter-plantuml",
				branch = "demo",
			},
		}

		parsers.swift = {
			install_info = {
				url = "https://github.com/tree-sitter/swift-tree-sitter",
				branch = "main",
			},
		}

		parsers.ion = {
			install_info = {
				url = "https://github.com/Ignis-lang/tree-sitter-ion.git",
				branch = "main",
				generate = true,
			},
		}
	end,
})

local treesitter_mode_on = function()
	vim.keymap.set("n", "<leader>sx", ":source ~/.config/nvim/thing.lua<CR>")
	vim.keymap.set("n", "<leader>ts", ":TSPlaygroundToggle<CR>")
	vim.notify("Treesitter mode on!")
end

-- vim.keymap.set("n", "<leader>1", treesitter_mode_on)
--

