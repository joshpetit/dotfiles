---@diagnostic disable: undefined-global
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require("packer").startup(function()
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		disable = true,
		config = function()
			require("mystuff/mappings").nvimTree()
			require("mystuff/settings").nvimTree()
		end,
	})
	use("EdenEast/nightfox.nvim")
	use({
		"williamboman/nvim-lsp-installer",
		requires = { "neovim/nvim-lspconfig" },
	})
	--use {'~/projects/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
	use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
	-- tag = 'release' -- To use the latest release
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"neovim/nvim-lspconfig",
			"dcampos/nvim-snippy",
			"dcampos/cmp-snippy",
		},
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- use {
	--     'TimUntersberger/neogit',
	--     requires = 'nvim-lua/plenary.nvim',
	--     config = function() require'neogit'.setup {} end
	-- }
	use({ "mhartington/formatter.nvim" })
	-- Git diffs on the column
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({})
		end,
	})
	use({
		"pwntester/octo.nvim",
		config = function()
			require("octo").setup()
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	-- Lua
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
	use({ "akinsho/toggleterm.nvim" })
	--use {"sheerun/vim-polyglot"}
	use("tversteeg/registers.nvim")
	use({ "tpope/vim-fugitive" })
	use({ "dcampos/nvim-snippy" })
	use({ "mfussenegger/nvim-dap" })
	use({ "Pocco81/DAPInstall.nvim" })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({ "nvim-treesitter/nvim-treesitter" })
	--use {'nvim-orgmode/orgmode'}
	use({ "~/projects/orgmode" })
	use({ "iamcco/markdown-preview.nvim" })
	-- use {'axvr/zepl.vim'}
	use({ "kraftwerk28/gtranslate.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use({ "delphinus/vim-firestore" })
	use({ "stevearc/dressing.nvim" })
	-- Gets a little annoying
	use({ "ray-x/lsp_signature.nvim" })
	use({ "simrat39/symbols-outline.nvim" })
	use("folke/lua-dev.nvim")
	-- F11, focused mode!
	use("Pocco81/TrueZen.nvim")
	-- Make vim start faster!
	-- use {
	--     'lewis6991/impatient.nvim',
	--     config = function() require('impatient') end
	-- }
	-- use {"vuki656/package-info.nvim", requires = "MunifTanjim/nui.nvim"}
	use({ "lervag/vimtex" })
	-- use {"jamestthompson3/nvim-remote-containers"}
	use({ "vim-test/vim-test" })
	use({ "tpope/vim-dispatch" })
	use({
		"rcarriga/vim-ultest",
		requires = { "vim-test/vim-test" },
		run = ":UpdateRemotePlugins",
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("tpope/vim-eunuch") -- SudoWrite!
	--use 'junegunn/fzf.vim'
	use("BurntSushi/ripgrep")
	-- \rf=Start R
	-- \pp to send paragraph
	-- \rm to remove previous output
	-- \kr to produce rmarkdown as html and open in browser
	use("jalvesaq/nvim-r")
	use("tpope/vim-rhubarb")
	use("shumphrey/fugitive-gitlab.vim")
	use("willchao612/vim-diagon")
	use("nvim-treesitter/playground")
	--     use({
	--   'noib3/nvim-cokeline',
	--   requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
	--   config = function()
	--     require('cokeline').setup()
	--   end
	-- })
	use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })
end)
