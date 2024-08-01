return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		sync_install = false,
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
	},
    lazy = false,
	config = function()
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		parser_config.puml = {
			install_info = {
				url = "https://github.com/ahlinc/tree-sitter-plantuml",
				revision = "demo",
				files = { "src/scanner.cc" },
			},
			filetype = "puml",
		}

		parser_config.swift = {
			install_info = {
				url = "https://github.com/tree-sitter/tree-sitter-swift",
				revision = "main",
				files = { "src/scanner.c" },
			},
			filetype = "swift",
		}
	end,
}
