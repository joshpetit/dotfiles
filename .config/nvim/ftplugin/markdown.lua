vim.bo[0].textwidth = 0
vim.bo[0].formatexpr = ""
vim.wo.conceallevel = 2

local journal_path = "/home/joshu/sync/wiki/dailies/"  -- Change this to your actual path

local function get_journal_entries()
    local files = {}
    local p = io.popen('ls "' .. journal_path .. '" | grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}\\.md$"')
    if p then
        for file in p:lines() do
            table.insert(files, file)
        end
        p:close()
    end
    table.sort(files)  -- Ensure chronological order
    return files
end

local function navigate_journal(direction)
    local entries = get_journal_entries()
    local current_file = vim.fn.expand("%:t")
    local index = nil

    for i, entry in ipairs(entries) do
        if entry == current_file then
            index = i
            break
        end
    end

    if index then
        local new_index = index + direction
        if new_index >= 1 and new_index <= #entries then
            vim.cmd("edit " .. journal_path .. entries[new_index])
        else
            print("No " .. (direction == -1 and "previous" or "next") .. " entry available.")
        end
    else
        print("Current file is not recognized as a journal entry.")
    end
end

vim.api.nvim_create_user_command("JournalPrev", function() navigate_journal(-1) end, {})
vim.api.nvim_create_user_command("JournalNext", function() navigate_journal(1) end, {})

vim.keymap.set("n", "<leader>n.", "<cmd>JournalNext<CR>")
vim.keymap.set("n", "<leader>n,", "<cmd>JournalPrev<CR>")

-- Track edits to wiki markdown files in a per-day edits file -----------------

local wiki_dir = vim.fn.expand("~/sync/wiki")
local dailies_dir = wiki_dir .. "/dailies"

local function in_dir(path, dir)
    return path:sub(1, #dir + 1) == dir .. "/"
end

-- Insert or bump the entry for `link` (a `[[wikilink]]`), incrementing the
-- write count for that file.
local function upsert_edit(lines, link)
    local function entry(n)
        return link .. " (" .. n .. ")"
    end

    for i, line in ipairs(lines) do
        local existing, num = line:match("^(%[%[.-%]%]) %((%d+)%)$")
        if existing == link then
            lines[i] = entry(tonumber(num) + 1)
            return lines
        end
    end

    table.insert(lines, entry(1))
    return lines
end

local function record_edit(link)
    local today = dailies_dir .. "/" .. os.date("%Y-%m-%d") .. ".edits.md"
    local bufnr = vim.fn.bufnr(today)
    local loaded = bufnr ~= -1 and vim.api.nvim_buf_is_loaded(bufnr)

    local lines = {}
    if loaded then
        lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    else
        local f = io.open(today, "r")
        if f then
            for line in f:lines() do
                table.insert(lines, line)
            end
            f:close()
        end
    end

    lines = upsert_edit(lines, link)

    if loaded then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        vim.api.nvim_buf_call(bufnr, function() vim.cmd("silent keepalt write") end)
    else
        local f = io.open(today, "w")
        if f then
            f:write(table.concat(lines, "\n") .. "\n")
            f:close()
        end
    end
end

local path = vim.fn.expand("%:p")
if in_dir(path, wiki_dir) and not in_dir(path, dailies_dir) then
    -- Clear any existing autocmd for this buffer so re-sourcing the ftplugin
    -- (FileType can fire more than once) doesn't stack duplicate handlers.
    local group = vim.api.nvim_create_augroup("WikiEditTracker" .. vim.api.nvim_get_current_buf(), { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        buffer = 0,
        callback = function()
            record_edit("[[" .. vim.fn.expand("%:t:r") .. "]]")
        end,
    })
end
