return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		-- Adapters
		"haydenmeade/neotest-jest",
		"sidlatau/neotest-dart",
	},
	config = function()
		require('neotest').setup({
			adapters = {
				require("neotest-jest")({
					jestCommand = "yarn test --",
				}),
				require("neotest-dart")({
					command = "flutter", -- Command being used to run tests. Defaults to `flutter`
					-- Change it to `fvm flutter` if using FVM
					-- change it to `dart` for Dart only tests
					use_lsp = true, -- When set Flutter outline information is used when constructing test name.
				}),
			},
		})
	end,
}
