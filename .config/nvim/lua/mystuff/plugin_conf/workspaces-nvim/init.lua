local M = {}
local last_workspace = ""
local current_workspace = ""

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
			end,
		},
		open = function()
			require("sessions").load(nil, { silent = true })
		end,
	},
})

M.open_last_workspace = function()
	print("Opening: " .. last_workspace)
	require("workspaces").open(last_workspace)
end

return M
