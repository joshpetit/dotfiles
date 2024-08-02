return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
	},
    config = function()
        require("flutter-tools").setup({
		lsp = {
			on_attach = require("mystuff/on_attach_conf"),
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			--- OR you can specify a function to deactivate or change or control how the config is created
			settings = { showTodos = true, completeFunctionCalls = true },
		},
		debugger = {
			enabled = true,
			run_via_dap = true,
			register_configurations = function() end,
		},
	})

    end
}
