require("xbase").setup({
	--- Log level. Set it to ERROR to ignore everything
	log_level = vim.log.levels.DEBUG,
	--- Options to be passed to lspconfig.nvim's sourcekit setup function.
	--- Usually empty map is sufficient, However, it is strongly recommended to use on_attach key to setup custom mapppings
	-- sourcekit = {}, --- Set it to nil to skip lspconfig's sourcekit setup
	sourcekit = {
		on_attach = require("mystuff.on_attach_conf"),
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	}, --- Set it to nil to skip lspconfig's sourcekit setup
	--- Statusline provider configurations
	--- Simulators to only include.
	--- run `xcrun simctl list` to get a full list of available simulator
	--- If the list is empty then all simulator available  will be included
	simctl = {
		log_level = vim.log.levels.DEBUG,
		iOS = {
			"iPhone 14 Pro", --- only use this devices
		},
		watchOS = {}, -- all available devices
		tvOS = {}, -- all available devices
	},
	--- Log buffer configurations
	--- Mappings
	mappings = {
		--- Whether xbase mapping should be disabled.
		enable = true,
		--- Open build picker. showing targets and configuration.
		build_picker = "<leader>xb", --- set to 0 to disable
		--- Open run picker. showing targets, devices and configuration
		run_picker = "<leader>xr", --- set to 0 to disable
		--- Open watch picker. showing run or build, targets, devices and configuration
		watch_picker = "<leader>xs", --- set to 0 to disable
		--- A list of all the previous pickers
		all_picker = "<leader>xf", --- set to 0 to disable
		--- vertical toggle log buffer
		toggle_vsplit_log_buffer = "<leader>xl",
	},
	code_actions = {
		enable = true,
		use_builtin_actions = true,
		custom_actions = {
			{
				title = "Cool Actions",
				action = function()
					print("WOWW")
				end,
			},
		},
	},
}) -- see default configuration bellow
