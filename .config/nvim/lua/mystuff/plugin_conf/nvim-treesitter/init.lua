require("nvim-treesitter.configs").setup({
	sync_install = false,
	highlight = {
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

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.puml = {
	install_info = {
		url = "https://github.com/ahlinc/tree-sitter-plantuml",
		revision = "demo",
		files = { "src/scanner.cc" },
	},
	filetype = "puml",
}

parser_config.puml = {
	install_info = {
		url = "https://github.com/tree-sitter/swift-tree-sitter",
		revision = "main",
		files = { "src/scanner.c" },
	},
	filetype = "swift",
}

local treesitter_mode_on = function()
	vim.keymap.set("n", "<leader>sx", ":source ~/.config/nvim/thing.lua<CR>")
	vim.keymap.set("n", "<leader>ts", ":TSPlaygroundToggle<CR>")
	vim.notify("Treesitter mode on!")
end

-- vim.keymap.set("n", "<leader>1", treesitter_mode_on)
--

parser_config["ion"] = {
  install_info = {
    url = "https://github.com/Ignis-lang/tree-sitter-ion.git",
    files = { "src/parser.c" },
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = true,
  },
  filetype = "ion",
}
