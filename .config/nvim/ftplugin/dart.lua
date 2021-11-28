local nmap = function(keys, command)
    vim.api.nvim_set_keymap('n', keys, command, {noremap = true, silent = true})
end

nmap('<leader>ra', '<cmd>FlutterRun<cr>')
nmap('<leader>et', '<cmd>lua GoToTestFile()<cr>')
nmap('<leader>rr', '<cmd>FlutterReload<cr>')
nmap('<leader>rR', '<cmd>FlutterRestart<cr>')
nmap('<leader>rq', '<cmd>FlutterQuit<cr>')
nmap('<leader>dV', '<cmd>FlutterVisualDebug<cr>')
nmap('<leader>dL', '<cmd>b __FLUTTER_DEV_LOG__<cr>')

function GoToTestFile()
    local file = vim.fn.expand('%')
    local testFile = 'test' .. string.sub(file, 4, -6) .. '_test.dart'
    print(testFile)
    vim.cmd("split " .. testFile)
end
