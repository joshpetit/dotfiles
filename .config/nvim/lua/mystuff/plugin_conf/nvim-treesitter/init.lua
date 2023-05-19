require("nvim-treesitter.configs").setup({
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<leader>k',
            node_incremental = '<leader>k',
            scope_incremental = '<leader>K',
            node_decremental = '<leader>j',
        }
    }
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
		url = "https://github.com/tree-sitter/tree-sitter-swift",
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

vim.keymap.set("n", "<leader>1", treesitter_mode_on)
