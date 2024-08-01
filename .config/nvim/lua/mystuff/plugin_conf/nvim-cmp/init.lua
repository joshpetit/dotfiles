return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"neovim/nvim-lspconfig",
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			enabled = function()
				return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
					or require("cmp_dap").is_dap_buffer()
			end,
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					require("snippy").expand_snippet(args.body) -- For `snippy` users.
				end,
			},
			mapping = {
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-l>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true })),
				["<C-j>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_next_item()
					end
				end, { "i", "s" }),
				["<C-k>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item()
					end
				end, { "i", "s" }),
				["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
			},
			completion = { autocomplete = false },
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- { name = 'vsnip' }, -- For vsnip users.
				{ name = "snippy" }, -- For snippy users.
				-- { name = 'luasnip' }, -- For luasnip users.
				{ name = "neorg" },
			}, {
				{ name = "buffer" },
			}),
		})
		cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

		cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
			sources = {
				{ name = "dap" },
			},
		})
	end,
}
