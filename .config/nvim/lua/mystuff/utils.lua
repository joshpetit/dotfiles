-- Call a function and if it errors out print the error it will continue with
-- the script though. use just like pcall, first argument the function and than
-- res tof arguments are the arguments to that function
M = {}

function Jcall(func, ...)
    local res, err = pcall(func, ...)
    if not res then
        print(err)
        return
    end
end

function FileExists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

function RunAndOutput(input)
    local cmd = vim.api.nvim_exec(input, true)
    local output = {}
    for line in cmd:gmatch("[^\n]+") do
        table.insert(output, line)
    end
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
    vim.cmd([[split]])
    vim.api.nvim_win_set_buf(0, buf)
end

function SplitString(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end

AsyncRun = function(command, args)
    os.execute(command .. " " .. args .. " &")
end

function _G.ReloadConfig()
    local hls_status = vim.v.hlsearch
    for name, _ in pairs(package.loaded) do
        if name:match("^mystuff") then
            package.loaded[name] = nil
        end
        if name:match("^my_px") then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    if hls_status == 0 then
        vim.opt.hlsearch = false
    end
end

function GetLastIndex(list)
    local last
    for i, v in pairs(list) do
        last = #list - 0
    end
    return last
end

function IsModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

return M
