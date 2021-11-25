require('utils')
local exports = {}

function exports.reload()
    -- Telescope will give us something like ju/colors.lua,
    -- so this function convert the selected entry to
    local function get_module_name(s)
        local module_name;

        module_name = s:gsub("%.lua", "")
        module_name = module_name:gsub("%/", ".")
        module_name = module_name:gsub("%.init", "")

        return module_name
    end

    local prompt_title = "~ neovim modules ~"

    -- sets the path to the lua folder
    local path = "~/.config/nvim/lua"

    local opts = {
        prompt_title = prompt_title,
        cwd = path,

        attach_mappings = function(_, map)
            -- Adds a new map to ctrl+e.
            map("i", "<c-e>", function(_)
                -- these two a very self-explanatory
                local entry =
                    require("telescope.actions.state").get_selected_entry()
                local name = get_module_name(entry.value)

                -- call the helper method to reload the module
                -- and give some feedback
                R(name)
            end)

            return true
        end
    }

    -- call the builtin method to list files
    require('telescope.builtin').find_files(opts)
end

function exports.cooler()
    -- Telescope will give us something like ju/colors.lua,
    -- so this function convert the selected entry to
    local prompt_title = "Cool Files"

    -- sets the path to the lua folder
    local path = "."

    local opts = {
        prompt_title = prompt_title,
        cwd = path,

        attach_mappings = function(_, map)
            map("n", "d", function(_)
                local entry =
                    require("telescope.actions.state").get_selected_entry()
                AsyncRun("dragon-drag-and-drop", entry.value)

            end)
            map("i", "<c-o>", function(_)
                local entry =
                    require("telescope.actions.state").get_selected_entry()
                AsyncRun("xdg-open", entry.value)

            end)

            return true
        end
    }

    require('telescope.builtin').find_files(opts)
end

return exports;
