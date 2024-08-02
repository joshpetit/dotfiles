function bemol()
 local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory'})[1]
 local ws_folders_lsp = {}
 if bemol_dir then
  local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
  if file then

   for line in file:lines() do
    table.insert(ws_folders_lsp, line)
   end
   file:close()
  end
 end

 for _, line in ipairs(ws_folders_lsp) do
  vim.lsp.buf.add_workspace_folder(line)
 end

end

return function(client, bufnr)
	-- if client.supports_method("textDocument/formatting") then
	-- 	vim.api.nvim_clear_autocmds({  buffer = bufnr })
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		buffer = bufnr,
	-- 		callback = function()
	-- 			lsp_formatting(bufnr)
	-- 		end,
	-- 	})
	-- end

	-- if client.server_capabilities.documentSymbolProvider then
 --        vim.o.statusline = "%{%v:lua.require'nvim-navic'.get_location()%}"
	-- 	navic.attach(client, bufnr)
	-- end

	client.server_capabilities.documentFormattingProvider = false
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	require("lsp_signature").on_attach()

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "<leader>cgD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "<leader>cgd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<leader>cgi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<leader>cst", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>cgt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>crn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	-- vim.keymap.set("n", "<leader>crn", ":IncRename " .. vim.fn.expand("<cword>"), { expr = true })
	-- vim.keymap.set("n", "<leader>crN", ":IncRename ")
	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	--buf_set_keymap("n", "<leader>ca", '<cmd>lua require("telescope.builtin").lsp_code_actions()<CR>', opts)
	buf_set_keymap("n", "<leader>csr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.keymap.set("n", "<leader>clS", [[:Telescope lsp_dynamic_workspace_symbols<cr>]])
	-- vim.keymap.set("n", "<leader>cls", [[:Telescope lsp_document_symbols<cr>]])
	buf_set_keymap("n", "<leader>csd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "<leader>c,", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<leader>c.", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>cld", "<cmd>Telescope diagnostics<CR>", opts)
	-- LSP formatting unreliable
	-- buf_set_keymap('n', '<leader>ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	buf_set_keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    -- bemol()
end

