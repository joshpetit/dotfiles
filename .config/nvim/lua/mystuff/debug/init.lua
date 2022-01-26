M = {}

M.node = function()
    print("attaching")
    require('dap').run({
        type = 'node2',
        request = 'attach',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        skipFiles = {'<node_internals>/**/*.js'}
    })
    require("dapui").open();
end

M.dart = function()
    require('dap').run('dart')
    require("dapui").open();
end

return M;
