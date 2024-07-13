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

M.java = function()
	local file = vim.fn.expand("%")
    local testFile = file:gsub("src", "tst")
    testFile = testFile:gsub(".java", "Test.java")
	vim.cmd("split " .. testFile)
end

M.java_return = function()
	local file = vim.fn.expand("%")
    local testFile = file:gsub("tst/", "src/")
    testFile = testFile:gsub("Test.java", ".java")
	vim.cmd("split " .. testFile)
end

return M
