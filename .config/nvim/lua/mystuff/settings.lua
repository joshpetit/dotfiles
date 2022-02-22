require("mystuff/utils")
local M = {}

vim.o.timeout = false
vim.g.mapleader = " "
vim.o.mouse = "a"
vim.o.relativenumber = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.termguicolors = true
vim.cmd('abbrev %% expand("%")')

M["nightfox"] = function()
	require("nightfox").load("nightfox", { transparent = true })
end

M["nvim-tree"] = function()
	local lib = require("nvim-tree.lib")
	function OpenNvimTreeFile()
		local node = lib.get_node_at_cursor()
		AsyncRun("dragon-drag-and-drop", node.absolute_path)
		print(node.absolute_path)
	end
	require("nvim-tree").setup({
		update_cwd = true,
		--update_focused_file = { enable = true, update_cwd = true },
		disable_netrw = false,
		hijack_netrw = false,
		view = {
			relativenumber = true,
			mappings = {
				custom_only = false,
				list = {
					{ key = { "D" }, cb = "<cmd>lua print(OpenNvimTreeFile())<cr>" },
				},
			},
		},
	})
end

vim.notify = require("notify")
vim.cmd([[
let test#strategy = "dispatch"
let g:vim_markdown_folding_disabled = 1
]])
-- Formatters
--
local prettierFormatter = {
	-- prettier
	function()
		return {
			exe = "prettier",
			args = {
				"--stdin-filepath",
				vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
				"--single-quote",
			},
			stdin = true,
		}
	end,
}

require("formatter").setup({
	filetype = {
		jsonc = prettierFormatter,
		markdown = prettierFormatter,
		["creole.markdown"] = prettierFormatter,
		lua = {
			-- luafmt
			function()
				return { exe = "stylua", stdin = true, args = { "-" } }
			end,
		},
		dart = {
			-- Shell Script Formatter
			function()
				return { exe = "dart", args = { "format" }, stdin = true }
			end,
		},
		-- org = {
		--     -- Shell Script Formatter
		--     function()
		--         return {exe = "go-org", args = {"render org"}, stdin = true}
		--     end
		-- },
		racket = {
			-- Shell Script Formatter
			function()
				return { exe = "raco ", args = { "fmt", "--width 80" }, stdin = true }
			end,
		},
	},
})

vim.g.nvim_tree_respect_buf_cwd = 1

require("dapui").setup()

require("nvim-treesitter.configs").setup({ autotag = { enable = true } })

require("trouble").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
})

local snippy = require("snippy")
snippy.setup({
	mappings = {
		is = { ["<Tab>"] = "expand_or_advance", ["<S-Tab>"] = "previous" },
		nx = { ["<leader>x"] = "cut_text" },
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.puml = {
	install_info = {
		url = "https://github.com/ahlinc/tree-sitter-plantuml",
		revision = "demo",
		files = { "src/scanner.cc" },
	},
	filetype = "puml",
}
parser_config.md = {
	install_info = {
		url = "https://github.com/ikatyang/tree-sitter-markdown",
		revision = "master",
		files = { "src/parser.c", "src/scanner.cc" },
	},
	filetype = "markdown",
}

require("nvim-treesitter.configs").setup({
	-- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
	highlight = {
		enable = true,
		disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
		-- disable = function(lang, bufnr)
		-- 	return lang == "org"
		-- end,
		additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
	},
	ensure_installed = { "org" }, -- Or run :TSUpdate org
})

M["orgmode"] = function()
    require('orgmode').setup_ts_grammar()
	require("orgmode").setup({
		org_agenda_files = { "~/sync/org/**/*" },
		org_default_notes_file = "~/sync/org/refile.org",
		org_deadline_warning_days = 5,
		org_agenda_start_on_weekday = 7,
		org_highlight_latex_and_related = "native",
		mappings = {
			org = {
				org_next_visible_heading = "g}",
				org_previous_visible_heading = "g{",
			},
		},
		notifications = { enabled = true },
		org_agenda_templates = {
			m = {
				description = "Working on Ms5",
				template = "** Working on Ms5 %<%Y-%m-%d>\nSCHEDULED: %t\n:LOGBOOK:\nCLOCK: %U\n:END:",
				target = "~/sync/org/refile.org",
				headline = "MS5 Timesheet",
			},
			i = {
				description = "Thoughts",
				template = "** %?",
				target = "~/sync/org/refile.org",
				headline = "Thoughts",
			},
			c = {
				description = "CRandom note",
				template = "* %?",
			},
			t = {
				description = "Todo",
				template = "* TODO: %?",
				target = "~/sync/org/todo.org",
			},
		},
		org_custom_expots = {
			z = {
				label = "Export to RTF format",
				action = function(exporter)
					local current_file = vim.api.nvim_buf_get_name(0)
					local target = vim.fn.fnamemodify(current_file, ":p:r") .. ".rtf"
					local command = { "pandoc", current_file, "-o", target }
					local on_success = function(output)
						print("Success!")
						vim.api.nvim_echo({ { table.concat(output, "\n") } }, true, {})
					end
					local on_error = function(err)
						print("Error!")
						vim.api.nvim_echo({ { table.concat(err, "\n"), "ErrorMsg" } }, true, {})
					end
					return exporter(command, target, on_success, on_error)
				end,
			},
		},
	})
end
vim.cmd([[
    let g:mkdp_filetypes = ['markdown', 'org']
    ]])

local dap = require("dap")

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
		processId = require("dap.utils").pick_process,
	},
}

dap.adapters.dart = {
	type = "executable",
	command = "node",
	args = { "/home/joshu/aur/Dart-Code/out/dist/debug.js", "flutter" },
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
		cwd = "${workspaceFolder}/examples/widgetbook_example/",
	},
}

require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
		},
	},
})

require("telescope").load_extension("fzf")

require("lsp_signature").setup({ floating_window = false, toggle_key = "<C-b>" })

M["nvim-r"] = function()
	vim.cmd([[
    let R_openhtml = 1
    let R_assign = 0
    "let R_csv_app = 'localc'
    ]])
end

M["null-ls"] = function()
	-- R markdown
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting

	local h = require("null-ls.helpers")
	local methods = require("null-ls.methods")

	local FORMATTING = methods.internal.FORMATTING

	local stylermd = h.make_builtin({
		name = "stylermd",
		method = { FORMATTING },
		filetypes = { "rmd" },
		generator_opts = {
			command = "R",
			args = h.range_formatting_args_factory({
				"--slave",
				"--no-restore",
				"--no-save",
				"-e",
				[[
        options(styler.quiet = TRUE)
        con <- file("stdin")
        temp <- tempfile("styler", fileext = ".Rmd")
        writeLines(readLines(con), temp)
        styler::style_file(temp)
        output <- paste0(readLines(temp), collapse = '\n')
        cat(output)
        close(con)
      ]],
			}),
			to_stdin = true,
		},
		factory = h.formatter_factory,
	})
	-- End R markdown
	--
	null_ls.setup({
		debug = true,
		sources = {
			-- Make builtin styler works with R file only
			formatting.styler.with({
				filetypes = { "r" },
			}),
			stylermd,
			require("null-ls").builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier.with({
				extra_filetypes = { "toml" },
			}),
			null_ls.builtins.formatting.google_java_format,
		},
	})
end

vim.cmd([[
"aug CSV_Editing
"		au!
"		au FileType csv :%ArrangeColumn
"aug end
]])

return M

-- Dart code configuration options
-- {
-- "adapters" {
--     "dart-code": {
--       "name": "dart",
--       "command": [
--          "node",
--          "$HOME/.vscode/<PATH TO BUNDLE>/src/debug/dart_debug_entry.js"
--       ],
--       "attach": {
--         "pidProperty": "observatoryUri",
--         "pidSelect": "ask"
--       }
--     }
-- },
-- "configurations": {
--   "Dart - Launch": {
--     "adapter": "dart-code",
--     "configuration": {
--       "request": "launch",
--       "cwd": "string",
--       "deviceId": "string",
--       "enableAsserts": "boolean",
--       "program": "string",
--       "showMemoryUsage": "boolean",
--       "flutterMode": "enum [ debug, release, profile ]",
--       "args": "array[string]",
--       "env": " ?? ",
--       "vmAdditionalArgs": "array[string]"
--     }
--   },
--   "Dart - Attach": {
--     "adapter": "dart-code",
--     "configuration": {
--       "request": "attach",
--       "cwd": "string",
--       "packages": "string"
--     }
--   }
-- }
