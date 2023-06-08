local null_ls = require("null-ls")

null_ls.setup({
	debug = true,
	default_timeout = 5000,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			extra_filetypes = { "toml", "svelte" },
		}),
		null_ls.builtins.formatting.google_java_format,
		null_ls.builtins.formatting.dart_format,
		null_ls.builtins.formatting.yamlfmt,
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.formatting.latexindent,
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.formatting.sqlformat,
		null_ls.builtins.formatting["swift_format"],
		require("typescript.extensions.null-ls.code-actions"),
	},
})

null_ls.deregister("swift-actions")
null_ls.register({
	name = "swift-actions",
	filetypes = { "swift" },
	generator = {
		fn = function()
			local swift_actions = require("my_px.swift")
			return {
				{
					title = "Add padding",
					action = function()
						swift_actions.add_modifier("padding", ".top", 4)
					end,
				},
				{
					title = "Add font",
					action = function()
						swift_actions.add_modifier("font", ".headline")
					end,
				},
			}
		end,
	},
})

null_ls.deregister("dart-actions")
null_ls.register({
	name = "dart-actions",
	method = { require("null-ls").methods.CODE_ACTION },
	filetypes = { "dart" },
	generator = {
		fn = function()
			local dart_actions = require("my_px.dart")
			local capable_actions = {}
			for _, action_generator in pairs(dart_actions) do
				table.insert(capable_actions, action_generator())
			end
			return capable_actions
		end,
	},
})
