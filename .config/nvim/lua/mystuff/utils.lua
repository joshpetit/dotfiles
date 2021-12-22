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
    for name,_ in pairs(package.loaded) do
        if name:match('^mystuff') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    if hls_status == 0 then
        vim.opt.hlsearch = false
    end
end

