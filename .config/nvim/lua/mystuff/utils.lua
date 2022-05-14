-- Call a function and if it errors out print the error it will continue with
-- the script though
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
