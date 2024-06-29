local dap = require("dap")
dap.set_log_level("TRACE")

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/apps/vscode-firefox-debug/dist/adapter.bundle.js" },
}

-- Exception filters are "All" and "Uncaught"
dap.configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file - PWA",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
	{
		name = "Next.js: debug server-side",
		type = "pwa-node",
		request = "launch",
		cwd = "${workspaceFolder}",
		runtimeExecutable = "npm",
		runtimeArgs = { "run-script", "dev" },
		sourceMaps = true,
	},
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach - PWA",
		processId = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach to 9229- PWA",
		processId = 9229,
		cwd = "${workspaceFolder}",
	},
	{
		type = "pwa-node",
		request = "launch",
		name = "Debug Jest Tests - PWA",
		-- trace = true, -- include debugger info
		runtimeExecutable = "node",
		runtimeArgs = {
			"./node_modules/jest/bin/jest.js",
			"--runInBand",
		},
		rootPath = "${workspaceFolder}",
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		internalConsoleOptions = "neverOpen",
	},
	{
		type = "firefox",
		name = "Debug with Firefox",
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
}
dap.configurations.javascript = dap.configurations.typescript
dap.configurations.typescriptreact = dap.configurations.typescript

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
		name = "Launch flutter (lib/main)",
		program = "${workspaceFolder}/lib/main.dart",
		cwd = "${workspaceFolder}",
	},
	{
		type = "dart",
		request = "launch",
		name = "Linux, lib/main",
		program = "${workspaceFolder}/lib/main.dart",
		args = { "-d", "Linux" },
		cwd = "${workspaceFolder}",
	},
	{
		type = "dart",
		request = "launch",
		name = "Macos, lib/main",
		program = "${workspaceFolder}/lib/main.dart",
		args = { "-d", "macos" },
		cwd = "${workspaceFolder}",
	},
	{
		type = "flutter",
		request = "launch",
		name = "Launch SSY Staging",
		program = "${workspaceFolder}/lib/main-staging.dart",
		cwd = "${workspaceFolder}",
		args = {
			"--flavor=staging",
			"--observatory-port=9200",
		},
	},
	{
		type = "flutter",
		request = "launch",
		name = "Launch SSY Staging - Release mode",
		program = "${workspaceFolder}/lib/main-staging.dart",
		cwd = "${workspaceFolder}",
		args = {
			"--flavor=staging",
			"--observatory-port=9200",
			"--release",
		},
	},
	{
		type = "flutter",
		request = "launch",
		name = "SSY Prod",
		program = "${workspaceFolder}/lib/main-prod.dart",
		cwd = "${workspaceFolder}",
		args = {
			"--flavor=prod",
		},
	},
	{
		type = "fluttertest",
		request = "launch",
		name = "Run flutter test File",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
	{
		type = "fluttertest",
		request = "launch",
		name = "Flutter Integration Test Staging",
		program = "${file}",
		cwd = "${workspaceFolder}",
		args = {
			"--flavor=staging",
		},
	},
	{
		type = "darttest",
		request = "launch",
		name = "Run dart test File",
		program = "${file}",
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
