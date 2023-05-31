local stuff = require("my_px.dart")

local nmap = function(keys, command)
	vim.keymap.set("n", keys, command)
end

nmap("<leader>ra", "<cmd>FlutterRun<cr>")
nmap("<leader>rs", "<cmd>FlutterRun --flavor staging --debug -t lib/main-staging.dart<cr>")
nmap("<leader>rp", "<cmd>FlutterRun --flavor prod --debug -t lib/main-prod.dart<cr>")
nmap("<leader>fcp", "<cmd>FlutterCopyProfilerUrl<cr>")
nmap("<leader>fv", "<cmd>FlutterVisualDebug<cr>")
nmap("<leader>rf", "<cmd>FlutterRun -t %<cr>")
nmap("<leader>rr", "<cmd>FlutterReload<cr>")
nmap("<leader>rR", "<cmd>FlutterRestart<cr>")
nmap("<leader>rq", "<cmd>FlutterQuit<cr>")
nmap("<leader>dV", "<cmd>FlutterVisualDebug<cr>")
nmap("<leader>dL", "<cmd>b __FLUTTER_DEV_LOG__<cr>")
nmap("<leader>da", '<cmd>lua require("mystuff/debug").dart()<cr>')

vim.keymap.set("n", "<leader>rF", function()
	-- vim.cmd([[new|0read !dart #:r]])
	vim.cmd([[!dart %]])
end)

vim.keymap.set("n", "<leader><leader>af", stuff.create_from_json)
vim.keymap.set("n", "<leader>fcl", ":FlutterLogClear<CR>")
vim.keymap.set("n", "<leader>flc", ":FlutterLogClear<CR>")

--vim.api.nvim_buf_create_user_command(0, 'SSY', 'FlutterRun --flavor staging --debug -t lib/main-staging.dart')
