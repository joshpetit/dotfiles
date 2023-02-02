local nmap = function(keys, command)
	vim.api.nvim_set_keymap("n", keys, command, { noremap = true, silent = true })
end

nmap("<leader>ra", "<cmd>FlutterRun<cr>")
nmap("<leader>rs", "<cmd>FlutterRun --flavor staging --debug -t lib/main-staging.dart<cr>")
nmap("<leader>fcp", "<cmd>FlutterCopyProfilerUrl<cr>")
nmap("<leader>rf", "<cmd>FlutterRun -t %<cr>")
nmap("<leader>rr", "<cmd>FlutterReload<cr>")
nmap("<leader>rR", "<cmd>FlutterRestart<cr>")
nmap("<leader>rq", "<cmd>FlutterQuit<cr>")
nmap("<leader>dV", "<cmd>FlutterVisualDebug<cr>")
nmap("<leader>dL", "<cmd>b __FLUTTER_DEV_LOG__<cr>")
nmap("<leader>da", '<cmd>lua require("mystuff/debug").dart()<cr>')

vim.keymap.set("n", "<leader>rF", function()
    vim.cmd([[new|0read !dart #:r]])
end)

--vim.api.nvim_buf_create_user_command(0, 'SSY', 'FlutterRun --flavor staging --debug -t lib/main-staging.dart')
