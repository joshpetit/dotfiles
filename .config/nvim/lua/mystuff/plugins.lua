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

	use_help({
		"nvim-neorg/neorg",
		config = function() end,
		run = ":Neorg sync-parsers",
		requires = {
			"hrsh7th/nvim-cmp",
			"nvim-lua/plenary.nvim",
			"nvim-neorg/neorg-telescope",
		},
		disable = true,
	}, true)

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
	use({ "dhruvasagar/vim-table-mode", disable = false })
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

	use({
		"shumphrey/fugitive-gitlab.vim",
		config = {
			vim.cmd([[
        let g:fugitive_gitlab_domains = ['https://gitlab.oit.duke.edu/']
        ]]),
		},
	})

	use_help({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
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
			require("nvim-ts-autotag").setup({})
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
		"williamboman/nvim-lsp-installer",
		requires = { "neovim/nvim-lspconfig" },
	}, true)
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
	use_help({
		"nvim-orgmode/orgmode",
		disable = true,
	}, true)
	-- use({
	-- 	"~/projects/orgmode",
	-- 	config = function()
	-- 		require("mystuff/settings")["orgmode"]()
	-- 	end,
	-- })
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	-- use {'axvr/zepl.vim'}
	use({
		"kraftwerk28/gtranslate.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		disable = false,
	})
	use({ "delphinus/vim-firestore" })
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
	-- F11, focused mode!
	use({ "folke/zen-mode.nvim" })
	-- Make vim start faster!
	-- use({
	-- 	"lewis6991/impatient.nvim",
	-- 	config = function()
	-- 		require("impatient")
	-- 	end,
	-- })
	use({ "lervag/vimtex" })
	use("tpope/vim-eunuch") -- SudoWrite!
	use("tpope/vim-rhubarb")
	use("nvim-treesitter/playground")
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
	use({ "mechatroner/rainbow_csv", disable = true })
	use("chrisbra/csv.vim")
	use({
		"weirongxu/plantuml-previewer.vim",
		requires = { "tyru/open-browser.vim", "aklt/plantuml-syntax" },
	})
	use("ferrine/md-img-paste.vim")
	use("tpope/vim-abolish")
	use("jbyuki/nabla.nvim")
	use({ "ThePrimeagen/harpoon" })
	-- use({
	--     "kwkarlwang/bufresize.nvim",
	--     config = function()
	--         require("bufresize").setup()
	--     end,
	-- })
	use({
		"axelvc/template-string.nvim",
		config = function()
			require("template-string").setup()
		end,
	})
	use("mustache/vim-mustache-handlebars")
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
	use({
		"ziontee113/color-picker.nvim",
		config = function()
			require("color-picker")
		end,
	})
	use("dstein64/vim-startuptime")
	use("cedarbaum/fugitive-azure-devops.vim")
	use_help({
		"L3MON4D3/LuaSnip",
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
		requires = { "rafamadriz/friendly-snippets" },
	}, true)

	use_help({
		"kkharji/xbase",
		run = "make install", -- or "make install && make free_space" (not recommended, longer build time)
		requires = {
			"neovim/nvim-lspconfig",
		},
		disable = true,
	}, true)

	use({ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" })

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	-- go directly to a file and line
	use("wsdjeg/vim-fetch")

	use({
		"tzachar/highlight-undo.nvim",
		config = function()
            require('highlight-undo').setup()
		end,
	})
    use("github/copilot.vim")

	if Packer_bootstrap then
		require("packer").sync()
	end
end)
