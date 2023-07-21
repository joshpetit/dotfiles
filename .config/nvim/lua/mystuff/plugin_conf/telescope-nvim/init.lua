local actions = require("telescope.actions")
local action_utils = require("telescope.actions.utils")
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "^.git/", "node_modules" },
		mappings = {
			i = {
				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<c-a>"] = actions.select_all,
				["<c-f>"] = function(prompt_bufnr)
					-- I literally just reinvented the quickfix list
					local active_files = {}
					action_utils.map_selections(prompt_bufnr, function(entry, _)
						table.insert(active_files, entry[1])
					end)
					actions.close(prompt_bufnr)
					vim.cmd("vnew")
					local win = vim.api.nvim_get_current_win()
					local buf = vim.api.nvim_create_buf(true, true)
					vim.api.nvim_win_set_buf(win, buf)
					vim.api.nvim_buf_set_lines(0, 0, 0, false, active_files)
				end,
				["<C-D>"] = function()
					local entry = require("telescope.actions.state").get_selected_entry()
					AsyncRun("dragon-drop", entry.value)
				end,
			},
			n = {
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer,
					["<c-o>"] = function(prompt_bufnr)
						actions.select_all(prompt_bufnr)
						actions.toggle_selection(prompt_bufnr)
						actions.delete_buffer(prompt_bufnr)
					end,
				},
				n = {
					["<c-d>"] = actions.delete_buffer,
				},
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("flutter")

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

return exports
