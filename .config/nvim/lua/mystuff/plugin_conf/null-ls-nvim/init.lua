local null_ls = require("null-ls")

null_ls.setup({
	debug = true,
	default_timeout = 5000,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			extra_filetypes = { "toml" },
		}),
		null_ls.builtins.formatting.google_java_format,
		null_ls.builtins.formatting.dart_format,
		null_ls.builtins.formatting.yamlfmt,
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.black,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.formatting.sqlformat,
        null_ls.builtins.formatting["swift-format"],
        require("typescript.extensions.null-ls.code-actions"),
	},
})

if not null_ls.is_registered("my-actions") then
	require("null-ls").register({
		name = "my-actions",
		method = { require("null-ls").methods.CODE_ACTION },
		filetypes = { "dart" },
		generator = {
			fn = function()
				return {
					{
						title = "Add toString",
						action = function()
							require("mystuff.plugin_conf.null-ls-nvim.dart").create_to_string()
						end,
					},
				}
			end,
		},
	})

	require("null-ls").register({
		name = "my-actions",
		method = { require("null-ls").methods.CODE_ACTION },
		filetypes = { "dart" },
		generator = {
			fn = function()
				return {
					{
						title = "Add fromJson",
						action = function()
							require("mystuff.plugin_conf.null-ls-nvim.dart").create_from_json()
						end,
					},
				}
			end,
		},
	})
end
