local dap = require("dap")

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/aur/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.typescript = {
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
	{
		name = "IDEK!",
		type = "node2",
		request = "attach",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		skipFiles = { "<node_internals>/**/*.js" },
	},
}

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
