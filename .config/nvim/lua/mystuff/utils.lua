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

function BreakLines(text, max_width, prefix)
	prefix = prefix or ""
	max_width = max_width or 80
	local result = {}
	local line = ""

	for word in text:gmatch("%S+") do
		if #line + #word + #prefix + 1 > max_width then
			table.insert(result, prefix .. line)
			line = word
		else
			line = (line ~= "") and line .. " " .. word or word
		end
	end
	table.insert(result, prefix .. line)

	return table.concat(result, "\n")
end

local function highlight_word(bufnr, line_num, word_index, hl_group)
	-- Check if the buffer number is valid
	if not vim.api.nvim_buf_is_valid(bufnr) then
		print("Invalid buffer number")
		return
	end

	-- Get the line content
	local line = vim.api.nvim_buf_get_lines(bufnr, line_num - 1, line_num, false)[1]

	-- Split the line into words
	local words = vim.split(line, "%s+", { trimempty = true })

	-- Check if the word index is within range
	if word_index > #words then
		print("Word index out of range")
		return
	end

	-- Get the word to be highlighted
	local word = words[word_index]
	local start_col = string.find(line, word, 1, true)
	local end_col = start_col + #word

	-- Apply the highlight
	vim.api.nvim_buf_add_highlight(bufnr, -1, hl_group, line_num - 1, start_col - 1, end_col - 1)
end

-- highlight_word(0, 10, 5, "CrossReferences")
-- highlight_word(0, 10, 5, "Identifier")
--

M.get_start_of_word_at_cursor_col = function()
	local cur_pos = vim.api.nvim_win_get_cursor(0)
	-- jump to beginning of word under cursor
	-- b: backward
	-- c: accept match right under cursor
	vim.fn.search(vim.fn.expand("<cword>"), "bc")
	local new_pos = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_win_set_cursor(0, cur_pos)
	-- zero-indexed, add 1 as example indicates 1 indexing
	local result = new_pos[2]
	return result
end

return M
