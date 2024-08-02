return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	lazy = false,
	version = false, -- last release is way too old and doesn't work on Windows
	opts = {
		sync_install = false,
		auto_install = false,
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
	config = function(_, opts)
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.config").setup(opts)
	end,
}
