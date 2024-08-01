-- TODO: Fix
local actions = require("telescope.actions")
local action_utils = require("telescope.actions.utils")

return {
	"nvim-telescope/telescope.nvim",
	config = function()
		require("telescope").setup({
			defaults = {
				path_display = function(opts, path)
					local tail = require("telescope.utils").path_tail(path)
					return string.format("%s (%s)", tail, path), { { { 1, #tail }, "Constant" } }
				end,
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
							AsyncRun("dragon-drop", '"' .. entry.value .. '"')
						end,
					},
					n = {
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				-- find_files = {
				-- 	find_command = { "rg", "--ignore", "-L", "--hidden", "--files" },
				-- },
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
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
}
