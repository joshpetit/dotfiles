local M = {}


local function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

--- Check if a directory exists in this path
local function isdir(path)
   -- "/" works on both Unix and Windows
   return exists(path.."/")
end

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
    local test_folder = "tst"
    local testFile = ""
    if not isdir(test_folder) then
        test_folder = "src/test"
        testFile = file:gsub("src/main", "src/test")
    else
        testFile = file:gsub("src", test_folder)
    end
    testFile = testFile:gsub("%.java", "Test.java")
	vim.cmd("split " .. testFile)
end

M.java_return = function()
	local file = vim.fn.expand("%")
    local test_folder = "tst"
    local testFile = file
    if not isdir(test_folder) then
        test_folder = "src/main"
        testFile = file:gsub("src/test", "src/main")
    else
        testFile = file:gsub(test_folder, "src/")
    end
    testFile = testFile:gsub("Test.java", ".java")
	vim.cmd("split " .. testFile)
end
return M
