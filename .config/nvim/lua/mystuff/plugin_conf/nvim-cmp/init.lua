local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- require("snippy").expand_snippet(args.body) -- For `snippy` users.
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-l>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
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
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	completion = { autocomplete = false },
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- { name = 'vsnip' }, -- For vsnip users.
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = "snippy" }, -- For snippy users.
		{ name = "orgmode" },
	}, { { name = "buffer" } }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- Look into adding https://github.com/rcarriga/cmp-dap
