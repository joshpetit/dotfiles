local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = require("mystuff/on_attach_conf")

local servers = {
	"tailwindcss",
	"sourcekit",
	"kotlin_language_server",
	--"jsonls",
	"jdtls",
	"svelte",
	"vuels",
	"cssls",
	"gopls",
	"bashls",
	"html",
	"awk_ls",
	"perlnavigator",
	"pyright",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		flags = { debounce_text_changes = 150 },
	})
end

local luaLspConfig = {
	cmd = { "lua-language-server" },
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

--local luadev = require("lua-dev").setup({lspconfig=luaLspConfig})
require("neodev").setup()

-- require'lspconfig'.sumneko_lua.setup(luaLspConfig)

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = { debounce_text_changes = 150 },
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

