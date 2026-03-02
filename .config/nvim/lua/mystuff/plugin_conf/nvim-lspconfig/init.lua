-- local lspconfig = vim.lsp.config
local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = require("mystuff/on_attach_conf")

local servers = {
	"tailwindcss",
	"sourcekit",
	"svelte",
	"kotlin_lsp",
	-- "smithy_ls",
	--"jsonls",
	-- "jdtls",
	"svelte",
	"markdown_oxide",
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
    if lsp == "markdown_oxide" then
		lspconfig[lsp].setup({
            capabilities = vim.tbl_deep_extend(
                'force',
                capabilities,
                {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                }
            ),
			on_attach = on_attach,
			flags = { debounce_text_changes = 150 },
			filetypes = { "markdown" },
		})
    elseif lsp == "typos_lsp" then
		lspconfig[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			flags = { debounce_text_changes = 150 },
			filetypes = { "markdown" },
		})
	else
		lspconfig[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			flags = { debounce_text_changes = 150 },
		})
	end
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

-- local luadev = require("lua-dev").setup({lspconfig=luaLspConfig})
-- require("lazydev").setup({})

lspconfig['lua_ls'].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = { debounce_text_changes = 150 },
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})
