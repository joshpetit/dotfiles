local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = require("mystuff/on_attach_conf")

local servers = {
	"tailwindcss",
	"null-ls",
	"sourcekit",
	"svelte",
	"kotlin_lsp",
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
	local config = {
		capabilities = capabilities,
		on_attach = on_attach,
		flags = { debounce_text_changes = 150 },
	}
	
	if lsp == "markdown_oxide" then
		config.capabilities = vim.tbl_deep_extend('force', capabilities, {
			workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
				},
			},
		})
		config.filetypes = { "markdown" }
	elseif lsp == "typos_lsp" then
		config.filetypes = { "markdown" }
	end
	
	vim.lsp.config[lsp] = config
    -- vim.lsp.enable(lsp) mason.nvim lspconfig thing will do this
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

vim.lsp.config.lua_ls = {
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
}
-- vim.lsp.enable('lua_ls') Mason.nvim lspconfig thign will do this
