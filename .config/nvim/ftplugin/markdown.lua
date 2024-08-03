local m = require("mystuff/mapping_utils")
local o = require("mystuff/option_utils")

m.nmap("<leader>mp", "<cmd>MarkdownPreview<cr>", { buffer = true })
m.cmap("ConvertPdf ", "<cmd>pandoc -i % -o %.pdf<cr>", { buffer = true })
o.set_buf_option("textwidth", 80)
vim.bo.formatexpr = ""

local function expand_link()
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
	-- TODO: make it be able to get version from markdown metadata
	local version = "ESV"
	local split_passage_ref = vim.split(passage_ref, " ", { trim = true })
	if split_passage_ref[3] ~= nil then
		version = split_passage_ref[3]
		passage_ref = split_passage_ref[1] .. " " .. split_passage_ref[2]
	end
	local book = split_passage_ref[1]
	vim.ui.select(
		{ "copy", "insert", "biblehub", "biblegateway", "biblegateway-context" },
		{ prompt = passage_ref, backend = "builtin" },
		function(res)
			if res == "copy" then
				local handle = io.popen("bible --version " .. version .. " " .. passage_ref)
				if handle == nil then
					vim.print("Failed to run command")
					return
				end
				local result = handle:read("*a")
				handle:close()
				vim.fn.setreg('"', result)
				vim.print("Copied to clipboard")
			elseif res == "insert" then
				local handle = io.popen("bible --version " .. version .. " " .. passage_ref)
				if handle == nil then
					vim.print("Failed to run command")
					return
				end
				local result = handle:read("*a")
				handle:close()

				local cursor = vim.api.nvim_win_get_cursor(0)
				local results_in_line = vim.fn.substitute(result, "\n", " ", "g")
				vim.api.nvim_buf_set_lines(bufnr, cursor[1], cursor[1] + 1, false, { "> " .. results_in_line })
				-- vim.api.nvim_win_set_cursor(0, {cursor[1], cursor[2] + #link})
			elseif res == "biblehub" then
				vim.fn.jobstart(
					"xdg-open https://biblehub.com/"
						.. book:lower()
						.. "/"
						.. split_passage_ref[2]:gsub(":", "-")
						.. ".htm"
				)
			elseif res == "biblegateway" then
				vim.fn.jobstart(
					'xdg-open "https://www.biblegateway.com/passage/?search='
						.. passage_ref
						.. "&version="
						.. version
						.. '"'
				)
			elseif res == "biblegateway-context" then
				local chapter = split_passage_ref[2]:match("%d+")
				local verse = split_passage_ref[2]:match(":%d+")
				verse = vim.fn.substitute(verse, ":", "", "")
				vim.print(chapter)
				vim.fn.jobstart(
					'xdg-open "https://www.biblegateway.com/passage/?search='
						.. book
						.. " "
						.. chapter
						.. "&version="
						.. version
						.. "#:~:text="
						.. verse
						.. '"'
				)
			end
		end
	)
	-- vim.print(result)
end

vim.keymap.set("n", "<LocalLeader>e", expand_link)
vim.keymap.set("n", "<leader>ne", expand_link)

vim.wo.conceallevel = 2

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
					local book = selected.value
					local current_line = vim.api.nvim_get_current_line()
					local link = ""
					if current_line ~= "" then
						link = " "
					end
					link = link .. "[[" .. book .. "|bible:" .. book .. "]]"
					local bufnr = vim.api.nvim_get_current_buf()
					local cursor = vim.api.nvim_win_get_cursor(0)
					vim.api.nvim_buf_set_text(
						bufnr,
						cursor[1] - 1,
						cursor[2] - 1,
						cursor[1] - 1,
						cursor[2] - 1,
						{ link }
					)
					-- vim.api.nvim_win_set_cursor(0, {cursor[1], cursor[2] + #link})
					vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + #link - 3 })

					-- Create a temporary keymap to tab tha will put them at the end of the link after

					vim.api.nvim_feedkeys("a", "n", true)
				end)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>ir", select_bible_verse)
vim.keymap.set("n", "<leader>nir", select_bible_verse)
vim.keymap.set("i", "<LocalLeader>ir", select_bible_verse)
