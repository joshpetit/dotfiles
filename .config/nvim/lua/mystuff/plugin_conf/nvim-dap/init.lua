local dap = require("dap")

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

dap.configurations.typescript = {
	{
		name = "Debug with Firefox",
		type = "firefox",
		request = "launch",
		reAttach = true,
		url = "http://localhost:3000",
		webRoot = "${workspaceFolder}",
		--firefoxExecutable = "/usr/bin/firefox",
	},
	{
		name = "Debug with Firefox - Attach",
		type = "firefox",
		request = "attach",
		reAttach = true,
		url = "http://localhost:3000",
		webRoot = "${workspaceFolder}",
		-- pathMappings = {
		-- 	{
		-- 		url = "http://127.0.0.1:3000/_next/",
		-- 		path = "${webRoot}/.next/",
		-- 	},
		-- },
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
		name = "Attach to process",
		type = "node2",
		request = "attach",
		sourceMaps = true,
		processId = require("dap.utils").pick_process,
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
}
dap.configurations.typescriptreact = dap.configurations.typescript
dap.configurations.javascript = dap.configurations.typescript

dap.adapters.dart = {
	type = "executable",
	command = "node",
	--args = { "/home/joshu/aur/Dart-Code/out/dist/debug.js", "flutter" },
	args = { "/home/joshu/aur/Dart-Code/out/dist/debug.js" },
}

dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch flutter",
		dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
		flutterSdkPath = "/opt/flutter",
		program = "${workspaceFolder}/lib/main.dart",
		cwd = "${workspaceFolder}",
	},
	{
		type = "dart",
		request = "launch",
		name = "Test flutter",
		dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
		flutterSdkPath = "/opt/flutter",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
	{
		type = "dart",
		request = "launch",
		name = "Launch flutter Linux",
		dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
		flutterSdkPath = "/opt/flutter",
		program = "${workspaceFolder}/lib/main.dart",
		deviceId = "linux",
		cwd = "${workspaceFolder}",
	},
	{
		type = "dart",
		request = "launch",
		name = "Launch Current File",
		dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
		flutterSdkPath = "/opt/flutter",
		program = "${file}",
		deviceId = "linux",
		cwd = "${workspaceFolder}",
	},
	{
		type = "dart",
		request = "launch",
		name = "Widgetbook Current File",
		flutterMode = "debug",
		dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
		flutterSdkPath = "/opt/flutter",
		program = "${file}",
		deviceId = "linux",
		cwd = "${workspaceFolder}/examples/widgetbook_example/",
	},
	{
		type = "dart",
		request = "attach",
		name = "Attach Widgetbook Current File",
		flutterMode = "debug",
		dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/",
		flutterSdkPath = "/opt/flutter",
		program = "${file}",
		deviceId = "linux",
		cwd = "${workspaceFolder}/examples/knobs_example/",
	},
}
