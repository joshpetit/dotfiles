local M = {}
local last_workspace = ""
local current_workspace = ""
local opened_workspaces = {}
local pre_open_bufs = {}

-- Tasks scope sessions: each task keeps its own session per workspace.
-- The default task uses sessions.nvim's normal location so existing sessions keep working,
-- other tasks live under <sessions_dir>/tasks/<task>/
local DEFAULT_TASK = "default"
local sessions_dir = vim.fn.stdpath("data") .. "/sessions"
local tasks_dir = sessions_dir .. "/tasks"
local current_task = DEFAULT_TASK

-- Mirrors how sessions.nvim names session files when `absolute = true`
local session_path = function(task)
	local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
	local file = cwd:gsub("/", "."):sub(2) .. "session"
	if task == DEFAULT_TASK then
		return sessions_dir .. "/" .. file
	end
	return tasks_dir .. "/" .. task .. "/" .. file
end

local load_task_session = function()
	local sessions = require("sessions")
	local path = session_path(current_task)
	if vim.fn.filereadable(path) == 1 then
		sessions.load(path, { silent = true })
		return
	end
	-- No layout for this workspace in this task yet, so start from the default task's layout
	local fallback = session_path(DEFAULT_TASK)
	if current_task ~= DEFAULT_TASK and vim.fn.filereadable(fallback) == 1 then
		sessions.load(fallback, { silent = true, autosave = false })
	end
	-- Start recording into this task's session file
	sessions.save(path)
end

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
			load_task_session()

			local opened_key = current_task .. "/" .. current_workspace
			if not opened_workspaces[opened_key] then
				opened_workspaces[opened_key] = true
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

M.current_task = function()
	return current_task
end

M.list_tasks = function()
	local tasks = { DEFAULT_TASK }
	for name, type in vim.fs.dir(tasks_dir) do
		if type == "directory" and name ~= DEFAULT_TASK then
			table.insert(tasks, name)
		end
	end
	return tasks
end

M.switch_task = function(name)
	if not name or name == "" or name == current_task then
		return
	end
	require("sessions").stop_autosave()
	current_task = name
	vim.notify("Task: " .. name)

	-- Reopen the current workspace so its layout for the new task gets loaded
	local workspace = require("workspaces").name()
	if workspace then
		require("workspaces").open(workspace)
	end
end

M.new_task = function(name)
	local create = function(input)
		if not input or vim.trim(input) == "" then
			return
		end
		local task = vim.trim(input):gsub("/", "-")
		vim.fn.mkdir(tasks_dir .. "/" .. task, "p")
		M.switch_task(task)
	end
	if name then
		create(name)
	else
		vim.ui.input({ prompt = "New task: " }, create)
	end
end

M.select_task = function()
	vim.ui.select(M.list_tasks(), {
		prompt = "Switch task (current: " .. current_task .. ")",
		format_item = function(task)
			return task == current_task and task .. " *" or task
		end,
	}, M.switch_task)
end

vim.api.nvim_create_user_command("TaskNew", function(opts)
	M.new_task(opts.args ~= "" and opts.args or nil)
end, { nargs = "?", desc = "Create a new task and switch to it" })

vim.api.nvim_create_user_command("TaskSwitch", function(opts)
	if opts.args ~= "" then
		M.switch_task(opts.args)
	else
		M.select_task()
	end
end, {
	nargs = "?",
	desc = "Switch to a task",
	complete = function()
		return M.list_tasks()
	end,
})

return M
