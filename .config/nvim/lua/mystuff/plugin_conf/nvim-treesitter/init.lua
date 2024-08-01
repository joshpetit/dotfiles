return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	opts = {
		sync_install = false,
		ensure_installed = {
			"bash",
			"c",
			"css",
			"dockerfile",
			"graphql",
			"html",
			"java",
			"javascript",
			"json",
			"lua",
			"python",
			"toml",
			"tsx",
			"typescript",
			"markdown",
			"markdown_inline",
			"yaml",
		},
		highlight = {
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
		additional_vim_regex_highlighting = false,
	},
}
