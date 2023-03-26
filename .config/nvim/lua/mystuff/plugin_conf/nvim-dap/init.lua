local dap = require("dap")
dap.set_log_level("TRACE")

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/apps/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/apps/vscode-firefox-debug/dist/adapter.bundle.js" },
}

-- Exception filters are "All" and "Uncaught"
dap.configurations.typescript = {
	{
		name = "Debug with Firefox",
		type = "firefox",
		request = "launch",
		reAttach = true,
		url = "http://localhost:3000",
		webRoot = "${workspaceFolder}",
		firefoxExecutable = "/usr/bin/firefox",
		firefoxArgs = { "-start-debugger-server 6000" },
	},
	{
		name = "Debug with Firefox - Attach",
		type = "firefox",
		request = "attach",
		reAttach = true,
		host = "127.0.0.1",
		url = "http://localhost:3000",
		webRoot = "${workspaceFolder}",
	},
	{
		name = "Run",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		outFiles = { "${workspaceFolder}/lib/**/*.js" },
	},
	{
		name = "Attach to 9229",
		type = "node2",
		request = "attach",
		port = 9229,
		sourceMaps = true,
		outDir = "${workspaceRoot}/lib",
		outFiles = { "${workspaceRoot}/lib/**/*.js" },
	},
	{
		name = "Attach to process",
		type = "node2",
		request = "attach",
		sourceMaps = true,
		processId = require("dap.utils").pick_process,
	},
}
dap.configurations.typescriptreact = dap.configurations.typescript
dap.configurations.javascript = dap.configurations.typescript

-- dap.adapters.dart = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { "/home/joshu/apps/Dart-Code/out/dist/debug.js", "flutter" },
-- 	--args = { "/home/joshu/apps/Dart-Code/out/dist/debug.js" },
-- }

dap.adapters.flutter = {
	type = "executable",
	command = "flutter",
	args = { "debug-adapter" },
}

dap.adapters.fluttertest = {
	type = "executable",
	command = "flutter",
	args = { "debug-adapter", "--test" },
}

dap.adapters.dart = {
	type = "executable",
	command = "dart",
	args = { "debug_adapter" },
}

dap.adapters.darttest = {
	type = "executable",
	command = "dart",
	args = { "debug_adapter", "--test" },
}

dap.configurations.dart = {
	{
		type = "flutter",
		request = "launch",
		name = "Launch SSY Staging",
		program = "${workspaceFolder}/lib/main-staging.dart",
		cwd = "${workspaceFolder}",
		args = {
			"--flavor=staging",
		},
	},
	{
		type = "flutter",
		request = "launch",
		name = "Launch flutter (lib/main)",
		program = "${workspaceFolder}/lib/main.dart",
		cwd = "${workspaceFolder}",
	},
	{
		type = "fluttertest",
		request = "launch",
		name = "Run flutter File",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
	{
		type = "dart",
		request = "launch",
		name = "Launch flutter Linux (lib/main)",
		program = "${workspaceFolder}/lib/main.dart",
		deviceId = "linux",
		cwd = "${workspaceFolder}",
	},
	{
		type = "dart",
		request = "launch",
		name = "Run Dart File",
		program = "${file}",
		deviceId = "linux",
		cwd = "${workspaceFolder}",
	},
}
