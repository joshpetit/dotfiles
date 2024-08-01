---@diagnostic disable: undefined-global
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- local fn = vim.fn
local fn = vim.fn
local PLUGIN_CONF_PATH = fn.stdpath("config") .. "/lua/mystuff/plugin_conf/"
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end
return require("packer").startup(function()
	local fileExists = function(file)
		local ok, err, code = os.rename(file, file)
		if not ok then
			if code == 13 then
				-- Permission denied, but it exists
				return true
			end
		end
		return ok, err
	end
	local use_help = function(params, create_config)
		local plugin = params[1]
		use(params)
		if create_config and not params.disable then
			local split = SplitString(plugin, "/")
			local plugin_name = split[GetLastIndex(split)]
			plugin_name = plugin_name:gsub("%.", "-")
			local plugin_dir = PLUGIN_CONF_PATH .. plugin_name .. "/"
			local dir_exists = fileExists(plugin_dir)
			if not dir_exists then
				os.execute("mkdir -p " .. plugin_dir)
			end
			local init_file = plugin_dir .. "init.lua"
			local init_exist = fileExists(init_file)
			if not init_exist then
				os.execute("touch " .. init_file)
			end
			Jcall(require, "mystuff/plugin_conf/" .. plugin_name)
		end
	end

	use("wbthomason/packer.nvim")
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	})
	use_help({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		disable = false,
	}, true)
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			vim.cmd(":colorscheme nightfox")
		end,
	})
	-- use {'~/projects/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
	use_help({
		"akinsho/flutter-tools.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	}, true)
	use({ "smancill/conky-syntax.vim", disable = true })
	-- use({ "dhruvasagar/vim-table-mode", disable = false })
	-- tag = 'release' -- To use the latest release
	use_help({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"neovim/nvim-lspconfig",
			"dcampos/nvim-snippy",
			"dcampos/cmp-snippy",
			"saadparwaiz1/cmp_luasnip",
		},
	}, true)
	use_help({
		"echasnovski/mini.nvim",
	}, true)

	use_help({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{ "BurntSushi/ripgrep" },
		},
	}, true)

	use({
		"nvim-lua/plenary.nvim",
	})

	use_help({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			-- Adapters
			"haydenmeade/neotest-jest",
			"sidlatau/neotest-dart",
		},
	}, true)
	-- Git diffs on the column
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({
		"phaazon/hop.nvim",
		config = function()
			require("hop").setup()
		end,
	})

	use_help({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
			vim.notify = require("notify")
		end,
	}, true)

	use({
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				css = true,
			})
		end,
		disable = false,
	})
	use({
		"windwp/nvim-ts-autotag",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	})
	use_help({
		"jose-elias-alvarez/typescript.nvim",
	}, true)
	use({ "tpope/vim-fugitive" })
	use_help({ "dcampos/nvim-snippy" }, true)
	use_help({ "honza/vim-snippets" }, false)

	use_help({ "mfussenegger/nvim-dap" }, true)
	use_help({
		"mfussenegger/nvim-jdtls",
		requires = {
			"mfussenegger/nvim-dap",
		},
	}, true)
	-- use_help({
	-- 	"williamboman/nvim-lsp-installer",
	-- 	requires = { "neovim/nvim-lspconfig" },
	-- }, true)

	use_help({
		"neovim/nvim-lspconfig",
		requires = { "folke/neodev.nvim" },
	}, true)
	use_help({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }, true)
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})
	use_help({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap", "rcarriga/cmp-dap" },
	}, true)
	use_help({ "nvim-treesitter/nvim-treesitter" }, true)
	use({
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				select = {
					--backend = {"builtin"}
				},
				input = {
					override = function(conf)
						conf.col = -1
						conf.row = 0
						return conf
					end,
				},
			})
		end,
	})
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	-- Gets a little annoying
	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				floating_window = false,
				toggle_key = "<C-b>",
			})
		end,
	})
	use({ "lervag/vimtex" })
	use("tpope/vim-eunuch") -- SudoWrite!
	use("tpope/vim-rhubarb")
	use_help({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	}, true)
	use({
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup({})
		end,
	})
	use("chrisbra/csv.vim")
	use("tpope/vim-abolish")
	use({
		"axelvc/template-string.nvim",
		config = function()
			require("template-string").setup()
		end,
	})
	use("ThePrimeagen/refactoring.nvim")
	use("chrisbra/NrrwRgn")
	use({ "aymericbeaumet/vim-symlink", requires = "moll/vim-bbye" })
	use({
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({
				input_buffer_type = "dressing",
			})
		end,
	})
	use_help({
		"L3MON4D3/LuaSnip",
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
		requires = { "rafamadriz/friendly-snippets" },
	}, true)

	use({ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" })

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use_help({
		"natecraddock/workspaces.nvim",
	}, true)
	use({
		"natecraddock/sessions.nvim",
	})

	use({
		"tzachar/highlight-undo.nvim",
		config = function()
			require("highlight-undo").setup()
		end,
	})
	use("github/copilot.vim")
	use("joshpetit/work")
	use_help({ "nilsboy/vim-rest-console" }, true)
	use_help({ "epwalsh/obsidian.nvim" }, true)
	use_help({ "nvim-orgmode/orgmode" }, true)
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({
				disable_max_size = 10000000000000,
				disable_max_lines = 1000000000000,
				backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
				filter_kind = false,
			})
		end,
	})
	use_help({ "zk-org/zk-nvim" }, true)
	use_help({
		"williamboman/mason.nvim",
	}, true)

	use({ "williamboman/mason-lspconfig.nvim" })
	if Packer_bootstrap then
		require("packer").sync()
	end
end)
