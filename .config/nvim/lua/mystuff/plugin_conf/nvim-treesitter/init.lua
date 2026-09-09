require('nvim-treesitter').setup()

require('nvim-treesitter').install {'javascript','typescript', 'java', 'markdown', 'markdown_inline' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
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

