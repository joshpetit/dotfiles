require("mystuff/utils")
local M = {}

vim.o.timeout = false
vim.g.mapleader = " "
vim.o.mouse = "a"
vim.o.relativenumber = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.termguicolors = true
--vim.cmd('abbrev %% expand("%")')

M["nightfox"] = function()
    --require("nightfox").load("nightfox", { transparent = true })
    vim.cmd(":colorscheme nightfox")
end

vim.notify = require("notify")
vim.cmd([[
let test#strategy = "dispatch"
let g:vim_markdown_folding_disabled = 1
]])
-- Formatters
--
vim.g.nvim_tree_respect_buf_cwd = 1


local dap = require("dap")

vim.cmd([[
    let g:mkdp_filetypes = ['markdown', 'org']
    ]])

dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/aur/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.typescript = {
    {
        name = "Run",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        outFiles = { "${workspaceFolder}/lib/**/*.js" },
    },
    {
        name = "Attach to process",
        type = "node2",
        request = "attach",
        sourceMaps = true,
        processId = require("dap.utils").pick_process,
    },
    {
        name = "Attach to 9229",
        type = "node2",
        request = "attach",
        port = 9229,
        sourceMaps = true,
        outDir = "${workspaceRoot}/lib",
        outFiles = { "${workspaceRoot}/lib/**/*.js" },
    },
    {
        name = "IDEK!",
        type = "node2",
        request = "attach",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**/*.js" },
    },
}

dap.adapters.dart = {
    type = "executable",
    command = "node",
    --args = { "/home/joshu/aur/Dart-Code/out/dist/debug.js", "flutter" },
    args = { "/home/joshu/aur/Dart-Code/out/dist/debug.js" },
}

dap.configurations.dart = {
    {
        type = "dart",
        request = "launch",
        name = "Launch flutter",
        dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
        flutterSdkPath = "/opt/flutter",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
    },
    {
        type = "dart",
        request = "launch",
        name = "Test flutter",
        dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
        flutterSdkPath = "/opt/flutter",
        program = "${file}",
        cwd = "${workspaceFolder}",
    },
    {
        type = "dart",
        request = "launch",
        name = "Launch flutter Linux",
        dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
        flutterSdkPath = "/opt/flutter",
        program = "${workspaceFolder}/lib/main.dart",
        deviceId = "linux",
        cwd = "${workspaceFolder}",
    },
    {
        type = "dart",
        request = "launch",
        name = "Launch Current File",
        dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
        flutterSdkPath = "/opt/flutter",
        program = "${file}",
        deviceId = "linux",
        cwd = "${workspaceFolder}",
    },
    {
        type = "dart",
        request = "launch",
        name = "Widgetbook Current File",
        flutterMode = "debug",
        dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
        flutterSdkPath = "/opt/flutter",
        program = "${file}",
        deviceId = "linux",
        cwd = "${workspaceFolder}/examples/widgetbook_example/",
    },
    {
        type = "dart",
        request = "attach",
        name = "Attach Widgetbook Current File",
        flutterMode = "debug",
        dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
        flutterSdkPath = "/opt/flutter",
        program = "${file}",
        deviceId = "linux",
        cwd = "${workspaceFolder}/examples/knobs_example/",
    },
}

require("lsp_signature").setup({ floating_window = false, toggle_key = "<C-b>" })

M["nvim-r"] = function()
    vim.cmd([[
    let R_openhtml = 1
    let R_assign = 0
    "let R_csv_app = 'localc'
    ]])
end

vim.cmd([[
"aug CSV_Editing
"		au!
"		au FileType csv :%ArrangeColumn
"aug end
]])

vim.cmd([[
function! g:LatexPasteImage(relpath)
    execute "normal! i\\includegraphics{" . a:relpath . "}\r\\caption{I"
    let ipos = getcurpos()
    execute "normal! a" . "mage}"
    call setpos('.', ipos)
    execute "normal! ve\<C-g>"
endfunction
autocmd FileType tex let g:PasteImageFunction = 'g:LatexPasteImage'
autocmd FileType markdown,tex nmap <buffer><silent> <leader>mp :call mdip#MarkdownClipboardImage()<CR>
]])

return M
