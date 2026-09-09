local M = {}
local last_workspace = ""
local current_workspace = ""
local opened_workspaces = {}
local pre_open_bufs = {}

require("workspaces").setup({
	auto_open = true,
	notify_info = false,
	hooks = {
		open_pre = {
			-- If recording, save current session state and stop recording
			"SessionsStop",

			-- delete all buffers (does not save changes)
			-- "silent %bdelete!",
			function(name, path, state)
				last_workspace = current_workspace
				current_workspace = name

				pre_open_bufs = {}
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_loaded(buf) then
						pre_open_bufs[buf] = true
					end
				end
			end,
		},
		open = function()
			require("sessions").load(nil, { silent = true })

			if not opened_workspaces[current_workspace] then
				opened_workspaces[current_workspace] = true
				vim.schedule(function()
					local visible = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						visible[vim.api.nvim_win_get_buf(win)] = true
					end
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        -- vim.print(buf)
                        -- vim.print(vim.api.nvim_buf_is_loaded(buf))
                        -- vim.print(visible[buf])
						if not visible[buf] and not pre_open_bufs[buf] then
							pcall(vim.api.nvim_buf_delete, buf, { force = true })
						end
					end
				end)
			end
		end,
	},
})

M.open_last_workspace = function()
	print("Opening: " .. last_workspace)
	require("workspaces").open(last_workspace)
end

return M
