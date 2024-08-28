local m = require("mystuff/mapping_utils")
local bible_utils = require("mystuff/bible_utils")
local bible_actions = require("mystuff/bible_actions")

vim.bo[0].textwidth = 80
vim.bo[0].formatexpr = ""
vim.wo.conceallevel = 2

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { buffer = true, noremap= true})
local function parse_markdown_bible_link_at_cursor()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local cursor_node = ts_utils.get_node_at_cursor()

	local link_query = vim.treesitter.query.parse(
		"markdown_inline",
		[[
    (link_text)@link_text
]]
	)
	local bufnr = vim.api.nvim_get_current_buf()

	if cursor_node == nil then
		return
	end
	-- TODO: make it find the next thing on the line
	-- TODO: make it let you expand on the paranetheses portion of a markdown link []( )
	if cursor_node:type() ~= "link_text" then
		for id, node in link_query:iter_captures(cursor_node, bufnr, 0, -1) do
			cursor_node = node
		end
	end
	-- vim.print(link_query)
	local link_text = vim.treesitter.get_node_text(cursor_node, bufnr)
	-- TODO: make it auto insert the bible: prefix if not found
	local split_link_text = vim.split(link_text, "bible:", { trim = true })
	local passage_ref = split_link_text[2]

	return passage_ref
end

local function expand_link()
	local passage_ref = parse_markdown_bible_link_at_cursor()
	bible_actions.handle_passage_ref(passage_ref)
end

vim.keymap.set("n", "<LocalLeader>e", expand_link)
vim.keymap.set("n", "<leader>ne", expand_link)

vim.keymap.set("n", "<leader>bo", function()
	local passage_ref = parse_markdown_bible_link_at_cursor()
	local passage = bible_utils.parse_reference(passage_ref)
	bible_actions.open_to_verse(passage)
end)


local bible_books = {
	"Genesis",
	"Exodus",
	"Leviticus",
	"Numbers",
	"Deuteronomy",
	"Joshua",
	"Judges",
	"Ruth",
	"1 Samuel",
	"2 Samuel",
	"1 Kings",
	"2 Kings",
	"1 Chronicles",
	"2 Chronicles",
	"Ezra",
	"Nehemiah",
	"Esther",
	"Job",
	"Psalms",
	"Proverbs",
	"Ecclesiastes",
	"Song of Solomon",
	"Isaiah",
	"Jeremiah",
	"Lamentations",
	"Ezekiel",
	"Daniel",
	"Hosea",
	"Joel",
	"Amos",
	"Obadiah",
	"Jonah",
	"Micah",
	"Nahum",
	"Habakkuk",
	"Zephaniah",
	"Haggai",
	"Zechariah",
	"Malachi",
	"Matthew",
	"Mark",
	"Luke",
	"John",
	"Acts",
	"Romans",
	"1 Corinthians",
	"2 Corinthians",
	"Galatians",
	"Ephesians",
	"Philippians",
	"Colossians",
	"1 Thessalonians",
	"2 Thessalonians",
	"1 Timothy",
	"2 Timothy",
	"Titus",
	"Philemon",
	"Hebrews",
	"James",
	"1 Peter",
	"2 Peter",
	"1 John",
	"2 John",
	"3 John",
	"Jude",
	"Revelation",
}

local actions = require("telescope.actions")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local pickers = require("telescope.pickers")
local action_state = require("telescope.actions.state")

local select_bible_verse = function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Books",
			finder = finders.new_table({
				results = bible_books,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)

					local selected = action_state.get_selected_entry()
					if not selected then
						return
					end
					-- insert the Bible book as a wiki link at the cursor
					local cursor = vim.api.nvim_win_get_cursor(0)
					local book = selected.value
					local current_line = vim.api.nvim_get_current_line()
					local link = ""
					local displace = #book + 8
					if current_line ~= "" then
						link = " "
					end
					-- link = link .. "[[" .. book .. "|bible:" .. book .. " ]]"
					link = link .. "[bible:" .. book .. " ](" .. book .. ")"
					local bufnr = vim.api.nvim_get_current_buf()
					vim.api.nvim_buf_set_text(
						bufnr,
						cursor[1] - 1,
						cursor[2] - 1,
						cursor[1] - 1,
						cursor[2] - 1,
						{ link }
					)
					-- vim.api.nvim_win_set_cursor(0, {cursor[1], cursor[2] + #link})
					vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + displace })

					-- Create a temporary keymap to tab that will put them at the end of the link after

					vim.api.nvim_feedkeys("a", "n", true)
				end)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>ir", select_bible_verse, { buffer = true })
vim.keymap.set("n", "<leader>bir", select_bible_verse, { buffer = true })
vim.keymap.set("i", "<LocalLeader>ir", select_bible_verse, { buffer = true })
vim.keymap.set("i", "<LocalLeader>ir", select_bible_verse, { buffer = true })
vim.keymap.set("n", "<leader>not", "<cmd>ObsidianToday<cr>", { buffer = true })
vim.keymap.set("n", "<leader>noy", "<cmd>ObsidianYesterday<cr>", { buffer = true })

-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	callback = function()
-- 		if vim.opt.foldmethod:get() == "expr" then
-- 			vim.schedule(function()
-- 				vim.opt.foldmethod = "expr"
-- 			end)
-- 		end
-- 	end,
-- })
vim.cmd([[
let g:markdown_folding = 1
set foldlevel=99
    ]])
local opts = { noremap = true, silent = false }
-- vim.api.nvim_set_keymap("n", "<TAB>", "za", opts)
local telescope = require("telescope")
vim.keymap.set("n", "<leader>bs", function()
	require("telescope.builtin").grep_string({
		hidden = true,
		search = "",
		search_dirs = { "~/texts" },
		path_display = "hidden",
		-- I want to make telescope highlight the first WORD of the search result
		display = function(entry)
			return "hi"
		end,
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			-- This breaks it for some reason lol
			-- "--no-line-number",
			"--column",
			"--smart-case",
		},
		attach_mappings = function(_, map)
			-- Adds a new map to ctrl+e.
			map({ "i", "n" }, "<c-e>", function(prompt_bufnr)
				-- these two a very self-explanatory
				local entry = require("telescope.actions.state").get_selected_entry()
				local passage_ref = vim.split(entry.text, "\t")[1]
				actions.close(prompt_bufnr)
				handle_passage_ref(passage_ref)

				-- if vim.api.nvim_get_mode().mode == "i" then
				-- 	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", true)
				-- end
				return true
			end)
			return true
		end,
	})
end, opts)

vim.o.ignorecase = true
vim.o.infercase = true
