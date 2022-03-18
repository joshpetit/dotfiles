local M = {}

M.dart = function()
	local file = vim.fn.expand("%")

    local testFile = file:gsub("lib/src", "test/src")
    local testFile = testFile:gsub(".dart", "_test.dart")
	vim.cmd("split " .. testFile)

end

return M
