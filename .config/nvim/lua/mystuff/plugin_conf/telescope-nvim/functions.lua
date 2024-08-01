local actions = require("telescope.actions")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
require("mystuff/utils")
local exports = {}

function exports.reload()
	-- Telescope will give us something like ju/colors.lua,
	-- so this function convert the selected entry to
	local function get_module_name(s)
		local module_name

		module_name = s:gsub("%.lua", "")
		module_name = module_name:gsub("%/", ".")
		module_name = module_name:gsub("%.init", "")

		return module_name
	end

	local prompt_title = "~ neovim modules ~"

	-- sets the path to the lua folder
	local path = "~/.config/nvim/lua/mystuff"

	local opts = {
		prompt_title = prompt_title,
		cwd = path,

		attach_mappings = function(_, map)
			-- Adds a new map to ctrl+e.
			map("i", "<c-e>", function(_)
				-- these two a very self-explanatory
				local entry = require("telescope.actions.state").get_selected_entry()
				local name = get_module_name(entry.value)

				-- call the helper method to reload the module
				-- and give some feedback
				R(name)
			end)
		end,
	}

	-- call the builtin method to list files
	require("telescope.builtin").find_files(opts)
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
			map("n", "D", function(_)
				local entry = require("telescope.actions.state").get_selected_entry()
				AsyncRun("dragon-drag-and-drop", entry.value)
			end)
			map("i", "<c-o>", function(_)
				local entry = require("telescope.actions.state").get_selected_entry()
				AsyncRun("xdg-open", entry.value)
			end)
			map("i", "<C-Up>", require("telescope.actions").cycle_history_prev)
			map("i", "<C-Down>", require("telescope.actions").cycle_history_next)
			return true
		end,
	}

	require("telescope.builtin").find_files(opts)
end

exports.search_by_workspace = function(opts)
	opts = opts or {}
	local workspaces = require("workspaces")
	local workspaces_list = workspaces.get()
	local width = 10
	for _, workspace in ipairs(workspaces_list) do
		if #workspace.name > width then
			width = #workspace.name + 2
		end
	end
	local entry_display = require("telescope.pickers.entry_display")
	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = width },
			{},
		},
	})
	pickers
		.new(opts, {
			prompt_title = "colors",
			finder = finders.new_table({
				results = workspaces_list,
				entry_maker = function(entry)
					return {
						value = entry,
						display = function(the_entry)
							return displayer({
								{ the_entry.ordinal },
								{ the_entry.value.path, "String" },
							})
						end,
						ordinal = entry.name,
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)

					local selected = action_state.get_selected_entry()
					if not selected then
						return
					end

					local workspace = selected.value
					if workspace and workspace ~= "" then
						require("telescope.builtin").find_files({
							hidden = true,
							search_dirs = { workspace.path },
						})
					end
				end)
				return true
			end,
		})
		:find()
end
return exports
