local stuff = require("my_px.dart")

local nmap = function(keys, command)
	vim.keymap.set("n", keys, command)
end

nmap("<LocalLeader>ra", "<cmd>FlutterRun<cr>")
nmap("<LocalLeader>rs", "<cmd>FlutterRun --flavor staging --debug -t lib/main-staging.dart<cr>")
nmap("<LocalLeader>rp", "<cmd>FlutterRun --flavor prod --debug -t lib/main-prod.dart<cr>")
nmap("<LocalLeader>fcp", "<cmd>FlutterCopyProfilerUrl<cr>")
nmap("<LocalLeader>fv", "<cmd>FlutterVisualDebug<cr>")
nmap("<LocalLeader>rf", "<cmd>FlutterRun -t %<cr>")
nmap("<LocalLeader>rr", "<cmd>FlutterReload<cr>")
nmap("<LocalLeader>R", "<cmd>FlutterRestart<cr>")
nmap("<LocalLeader>rq", "<cmd>FlutterQuit<cr>")
nmap("<LocalLeader>dV", "<cmd>FlutterVisualDebug<cr>")
nmap("<LocalLeader>dl", "<cmd>b __FLUTTER_DEV_LOG__<cr>")

vim.keymap.set("n", "<leader>rF", function()
	-- vim.cmd([[new|0read !dart #:r]])
	vim.cmd([[!dart %]])
end)

vim.keymap.set("n", "<LocalLeader>af", stuff.create_from_json)
vim.keymap.set("n", "<LocalLeader>cl", ":FlutterLogClear<CR>")
vim.keymap.set("n", "<LocalLeader>lc", ":FlutterLogClear<CR>")

--vim.api.nvim_buf_create_user_command(0, 'SSY', 'FlutterRun --flavor staging --debug -t lib/main-staging.dart')

-- local get_session = function()
-- 	return require("dap").session()
-- end
--
-- local send_command = function(command)
-- 	get_session():request(command)
-- end
--
-- nmap("<leader>rr", function()
-- 	send_command("hotReload")
-- end)
-- nmap("<leader>rR", function()
-- 	send_command("hotRestart")
-- end)
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "dart",
--     callback = function()
--         vim.schedule(function()
--             send_command("hotReload")
--         end)
--     end
-- })
