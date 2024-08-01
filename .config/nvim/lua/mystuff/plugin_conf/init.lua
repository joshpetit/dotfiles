return {
	{
		"EdenEast/nightfox.nvim",
        priority = 1,
		config = function()
			vim.cmd(":colorscheme nightfox")
		end,
	},

	-- Git diffs on the column
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"phaazon/hop.nvim",
		opts = {},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#000000",
		},
		config = function()
			vim.notify = require("notify")
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		disable = false,
		opts = {
			css = true,
		},
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		opts = {},
	},

	{
		"jose-elias-alvarez/typescript.nvim",
		opts = {
			server = {
				on_attach = require("mystuff/on_attach_conf"),
			},
		},
	},

	{ "tpope/vim-fugitive" },
	{
		"dcampos/nvim-snippy",
		opts = {
			mappings = {
				is = { ["<Tab>"] = "expand_or_advance", ["<S-Tab>"] = "previous" },
				nx = { ["<leader>x"] = "cut_text" },
			},
		},
	},
	{ "honza/vim-snippets" },

	{
		"mxsdev/nvim-dap-vscode-js",
		opts = {
			-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
			-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
			-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
			-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
			-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
		},
		dependencies = { "mfussenegger/nvim-dap" },
	},

	{
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},

	{
		"rcarriga/nvim-dap-ui",

		dependencies = { "mfussenegger/nvim-dap", "rcarriga/cmp-dap", "nvim-neotest/nvim-nio" },
		opts = {},
	},

	{
		"stevearc/dressing.nvim",
		opts = {
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
		},
	},

	--
	-- Gets a little annoying
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				floating_window = false,
				toggle_key = "<C-b>",
			})
		end,
	},
	{ "lervag/vimtex" },
	{ "tpope/vim-eunuch" }, -- SudoWrite!
	{ "tpope/vim-rhubarb" },

	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
	},
	{ "chrisbra/csv.vim" },
	{ "tpope/vim-abolish" },

	{
		"axelvc/template-string.nvim",
		opts = {},
	},

	{ "ThePrimeagen/refactoring.nvim" },

	{ "chrisbra/NrrwRgn" },

	{ "aymericbeaumet/vim-symlink", dependencies = "moll/vim-bbye" },

	{
		"smjonas/inc-rename.nvim",
		opts = {
			input_buffer_type = "dressing",
		},
	},

	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{

		"williamboman/mason-lspconfig.nvim",
		dependencies = "williamboman/mason.nvim",
		opts = {},
	},

	{ "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" },

	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"natecraddock/sessions.nvim",
	},
	{
		"tzachar/highlight-undo.nvim",
		opts = {},
	},

	{ "github/copilot.vim" },
	{ "git@github.com:joshpetit/work.git", enabled = false },

	{
		"nilsboy/vim-rest-console",
		init = function()
			vim.cmd([[
let g:vrc_trigger= '<leader>r'
" let g:vrc_show_command_in_quickfix = 0
" let g:vrc_show_command_in_result_buffer = 1
" let g:vrc_debug = 1
 let g:vrc_auto_format_response_enabled = 1
 let b:vrc_response_default_content_type = 'application/json'
]])
		end,
	},

	{
		"epwalsh/obsidian.nvim",
		opts = {
			workspaces = {
				{
					name = "Controversia Prophetica",
					path = "~/sync/obsidian",
				},
			},
		},

		{
			"stevearc/aerial.nvim",
			opts = {
				disable_max_size = 10000000000000,
				disable_max_lines = 1000000000000,
				backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
				filter_kind = false,
			},
		},
	},
	{ "zk-org/zk-nvim" },
	{
		"nvim-orgmode/orgmode",
		lazy = "VeryLazy",
		ft = { "org" },
		opts = {
			org_agenda_files = { "~/sync/org/**/*" },
			org_default_notes_file = "~/sync/org/refile.org",
			org_deadline_warning_days = 5,
			org_agenda_start_on_weekday = 7,
			org_todo_keywords = { "TODO(t)", "REVIEW(r)", "|", "DONE(d)" },
			-- Float doesn't open the items in different buffer correctly.
			-- win_split_mode  = 'float',
			org_highlight_latex_and_related = "native",
			highlight = {
				additional_vim_regex_highlighting = { "org" },
			},
			mappings = {
				org = {
					org_next_visible_heading = "g}",
					org_previous_visible_heading = "g{",
				},
			},
			notifications = { enabled = true },
			org_agenda_templates = {
				i = {
					description = "Thoughts",
					template = "** %?",
					target = "~/sync/org/life.org",
					headline = "Thoughts",
				},
				n = {
					description = "Random note",
					template = "* %?",
				},
			},
		},
	},
}
