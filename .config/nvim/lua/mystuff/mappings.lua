local m = require("mystuff/mapping_utils")

local nmap = function(keys, command)
	vim.keymap.set("n", keys, command)
end

nmap("<leader>ef", function()
	local ft = vim.bo.filetype
	vim.cmd("split ~/.config/nvim/ftplugin/" .. ft .. ".lua")
end)

nmap("<leader>et", function()
	local ft = vim.bo.filetype
	require("mystuff/test_path")[ft]()
end)

nmap("<leader>TT", function()
	if vim.treesitter.show_tree == nil then
		vim.treesitter.inspect_tree()
	else
		vim.treesitter.show_tree()
	end
end)

nmap("<leader>ggf", function()
	---@diagnostic disable-next-line: missing-parameter
	local file = vim.fn.expand("%")
	vim.cmd([[:Git]])
	vim.fn.search(file, "W")
	print(file)
end)


-- may be useful in future: vim.fn.empty(vim.fn.win_findbuf(buf))
local dap_open_window = function(buffer_name)
	local buffers = vim.api.nvim_list_bufs()
	for _, buf in pairs(buffers) do
		local cbuf = vim.bo[buf]
        vim.print(cbuf.filetype)
		if cbuf.filetype == buffer_name then
            local winVal = vim.fn.bufwinnr(buf)
			if not (winVal == -1) then
                vim.cmd("execute bufwinnr(" .. buf .. " ) 'wincmd w'")
			else
				vim.cmd("vsplit #" .. buf)
			end
		end
	end
end

nmap("<leader>dvb", function()
	dap_open_window("dapui_breakpoints")
end)
nmap("<leader>dvs", function()
	dap_open_window("dapui_scopes")
end)
nmap("<leader>dvr", function()
	dap_open_window("dap-repl")
end)

local toggle_quick_fix = function()
	local buffers = vim.api.nvim_list_bufs()
	for _, buf in pairs(buffers) do
		local cbuf = vim.bo[buf]
		if cbuf.filetype == "qf" and cbuf.buflisted then
			vim.cmd(":cclose")
			return
		end
	end
	vim.cmd([[copen]])
end

nmap("<leader>qf", toggle_quick_fix)

nmap("<leader>es", function()
	local ft = vim.bo.filetype
	vim.cmd(":split ~/.config/nvim/snippets/" .. ft .. ".snippets")
end)

nmap("<c-w>bo", ":%bdelete|edit #|normal `<cr>")
nmap("<leader>tn", [[:lua require("neotest").run.run()<cr>]])
nmap("<leader>tl", [[:lua require("neotest").run.run_last()<cr>]])
m.nmap("<leader>tt", "<cmd>TestSuite<cr>")
nmap("<leader>tt", [[:lua require("neotest").run.run({suite = true})<cr>]])
nmap("<leader>tf", [[:lua require("neotest").run.run(vim.fn.expand("%"))<cr>]])
nmap("<leader>ts", [[:lua require("neotest").summary.toggle()<cr>]])

-- Debug the last test ran
nmap("<leader>td", [[:lua require("neotest").run.run_last({ strategy = "dap" })<cr>]])
-- debug the entire test file
nmap("<leader>tD", [[:lua require("neotest").run.run({vim.fn.expand("%"), strategy = "dap"})<cr>]])

nmap("<leader>ct", [[:Trouble<cr>]])
nmap("<leader>cpl", [[:let @+ = fnamemodify(expand("%"), ":~:.") . ':' . line('.')<cr>]])
nmap("<leader>cpp", [[:let @+ = fnamemodify(expand("%"), ":~:.")<cr>]])
nmap("<leader>cpf", [[:let @+ = expand('%:t')<cr>]])

nmap("<S-q>", "<cmd>NvimTreeToggle<cr>")
--m.nmap("<S-q>", "<cmd>NvimTreeFindFileToggle<cr>")
nmap("<leader>nf", "<cmd>NvimTreeFindFileToggle<cr>")

-- Harpoon
nmap("<leader>ha", [[:lua require("harpoon.mark").add_file()<cr>]])
nmap("<leader>hs", [[:lua require("harpoon.ui").toggle_quick_menu()<cr>]])
nmap("<leader>a", [[:HopWord<cr>]])

nmap("<leader>pp", ":lua require('nabla').popup()<CR>")
m.nmap("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
nmap("<leader>w", "<Cmd>w<CR>")
nmap("<leader><s-w>", "<Cmd>SudoWrite!<CR>")
nmap("<leader><c-f>", '<cmd>Telescope grep_string search=""<cr>')
nmap("<leader>fb", "<cmd>Telescope buffers<cr>")
nmap("<leader><leader><c-f>", "<cmd>Telescope live_grep<cr>")
nmap("<leader>fb", "<cmd>Telescope buffers<cr>")
nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nmap("<c-f>", "<cmd>Telescope find_files<CR>")
nmap("c,", "<cmd>cprev<cr>")
nmap("c.", "<cmd>cnext<cr>")
nmap("<leader>,", "<cmd>bprev<cr>")
nmap("<leader>.", "<cmd>bnext<cr>")
--m.nmap("<leader>ff", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>")
nmap("<leader>ff", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
m.vmap("<leader>ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
nmap("di$", "T$dt$")
nmap("ci$", "T$ct$")
nmap("<leader>hn", "<cmd>:setlocal nonumber norelativenumber<CR>")
nmap("<leader>hN", "<cmd>:setlocal number relativenumber<CR>")
nmap("-", "<C-W><")
nmap("_", "<C-W>>")
nmap("=", "<C-W>-")
nmap("+", "<C-W>+")

vim.cmd([[
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
]])

nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("<c-h>", "<c-w>h")
nmap("<c-l>", "<c-w>l")
m.cmap("<c-j>", "<Down>")
m.cmap("<c-k>", "<Up>")

nmap("<leader>sf", "/\\c")
nmap("<leader>sb", "?\\c")

nmap("<leader>nh", "<cmd>noh<CR>")

-- Git
nmap("<leader>gs", ":Git<CR> :call search('Un')<CR>")
nmap("<leader><leader>gs", ":Git<CR>:call search(expand('%'))<CR>")
nmap("<leader>gmo", "<cmd>!git merge origin/master<CR>")
nmap("<leader>gcb", ":Git checkout ")
nmap("<leader>gcl", ":Git checkout -<cr>")
nmap("<leader>gpo", "<cmd>Git push -u origin HEAD<CR>")
nmap("<leader>gpu", "<cmd>Git push origin HEAD<CR>")
nmap("<leader>gpl", "<cmd>Git pull<CR>")
nmap("<leader>gb", "<cmd>Git blame<CR>")
nmap("<leader>glc", "<cmd>Gclog<CR>")
nmap("<leader>gif", "<cmd>Git update-index --assume-unchanged %<CR>")
nmap("<leader>gla", "<cmd>!git ls-files -v | grep '^[[:lower:]]'<CR>")
nmap("<leader>giF", "<cmd>Git update-index --no-assume-unchanged %<CR>")

nmap("<leader>ev", "<cmd>e ~/.config/nvim/init.lua<ENTER>")
nmap("<F11>", [[<cmd>lua require("zen-mode").toggle({window = { width = .65, height = .75 } })<cr>]])
-- m.nmap("<leader>nc", "<Plug>kommentary_jine_default")
-- m.vmap("<leader>nc", "<Plug>kommentary_visual_default")

nmap("<leader>sv", "<cmd>lua ReloadConfig()<cr>")
vim.cmd("command! ReloadConfig lua ReloadConfig()")
nmap("<leader>db", '<cmd>lua require("dap").toggle_breakpoint()<cr>')
nmap("<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
nmap("<leader>dl", "<cmd>lua require'dap'.step_into()<cr>")
nmap("<leader>dk", "<cmd>lua require'dap'.step_out()<cr>")
nmap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
nmap("<leader>de", "<cmd>lua require'dap'.set_exception_breakpoints()<cr>")
nmap("<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<CR>")
nmap("<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>")
nmap("<leader>dR", "<cmd>lua require'dap'.restart()<CR>")
nmap("<leader>dtc", "<cmd>lua require'dap'.run_to_cursor()<CR>")
nmap("<leader>du", [[<cmd>lua require("dapui").toggle({ reset = true})<CR>]])
nmap("<leader>dq", "<cmd>lua require'dap'.terminate(); require'dapui'.close()<cr>")
nmap("<leader>nc", "<cmd>lua require('notify').dismiss()<cr>")
nmap("<leader>nC", "<cmd>lua require('notify').dismiss({ silent = true, pending = true})<cr>")
nmap("<leader>ps", "<cmd>PackerSync<cr>")
--m.imap('<c-e>', "<esc><leader><cr>")
