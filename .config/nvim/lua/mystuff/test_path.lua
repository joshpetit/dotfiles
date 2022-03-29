local M = {}

local function getFile()
    return vim.fn.expand("%")
end

M.dart = function()
	local file = vim.fn.expand("%")
    local testFile = file:gsub("lib/src", "test/src")
    testFile = testFile:gsub(".dart", "_test.dart")
	vim.cmd("split " .. testFile)
end

M.typescriptreact = function()
    local file = getFile()
end

return M
