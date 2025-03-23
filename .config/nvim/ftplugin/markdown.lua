
vim.bo[0].textwidth = 80
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
