local utils = require("mystuff.utils")
local bible_utils = require("mystuff.bible_utils")
local actions = require("mystuff.bible_actions")

vim.bo[0].modifiable = false
vim.wo[0].cursorline = true
-- Probably will use this  https://github.com/junegunn/vim-easy-align

local show_strongs = function()
	local original_window = vim.api.nvim_get_current_win()
	local strongs_buf = vim.fn.bufnr("Strongs")
	if strongs_buf == -1 then
		vim.cmd("new")
		strongs_buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_set_current_win(original_window)
		vim.bo[strongs_buf].buftype = "nofile"
		-- vim.bo[strongs_buf].bufhidden = "hide"
		vim.bo[strongs_buf].swapfile = false
		-- vim.bo[strongs_buf].buflisted = false
		vim.bo[strongs_buf].filetype = "strongs"
		vim.bo[strongs_buf].modifiable = true
		vim.api.nvim_buf_set_name(strongs_buf, "Strongs")
	end
	local strongs_buf_open = false
	for _, winr in pairs(vim.api.nvim_list_wins()) do
		strongs_buf_open = strongs_buf_open or vim.api.nvim_win_get_buf(winr) == strongs_buf
	end
	if not strongs_buf_open then
		vim.cmd([[new]])
		vim.api.nvim_set_current_buf(strongs_buf)
	end

	vim.api.nvim_set_current_win(original_window)

	local line = vim.api.nvim_get_current_line()
	-- print(line)
	local passage_split = vim.split(line, "\t")
	local reference = passage_split[1]
	local passage = passage_split[2]
	local length_so_far = #reference + 1
	local words_split = vim.split(passage, " ")

	-- This finds the location of the word at the cursor in the passage
	local start_word_at_cursor = utils.get_start_of_word_at_cursor_col()
	local matching_index = nil

	for i, word in ipairs(words_split) do
		if length_so_far < start_word_at_cursor then
			length_so_far = length_so_far + #word + 1
		else
			matching_index = i
			break
		end
	end

	for the_i, the_word in ipairs(words_split) do
		words_split[the_i] = the_word:match("([%w]+)")
	end
	local diatheke_output = vim.fn.system("diatheke -b NASB -o n -k " .. reference):lower()
	local last_lemma

	for i, word in ipairs(words_split) do
		local next_lemma_position = diatheke_output:find('lemma="strong:')
		local word_position_in_output = diatheke_output:find(word:lower())
		if not word_position_in_output then
			break
		end

		if next_lemma_position and next_lemma_position < word_position_in_output then
			last_lemma = diatheke_output:match('lemma="strong:(%w+)"')
		end

		if i == matching_index then
			break
		else
			diatheke_output = diatheke_output:sub(word_position_in_output + #word)
		end
	end

	local is_hebrew = last_lemma:sub(1, 1) == "h"
	local lemma = last_lemma:sub(2)
	local strongs_output
	if is_hebrew then
		strongs_output = vim.fn.system("diatheke -b StrongsHebrew -k " .. lemma)
	else
		strongs_output = vim.fn.system("diatheke -b StrongsGreek -k " .. lemma)
	end
	local lines_to_add = vim.split(strongs_output, "\n")
	vim.api.nvim_buf_set_lines(strongs_buf, 0, -1, false, lines_to_add)
	-- TODO later: Add a little indicator that this word is not in the original language by seeing if a </w> tag is present

	-- local start = vim.cmd([[call matchstr(getline('.'), '\k*', getpos('.')[2]-1)]])
end

vim.keymap.set("n", "<leader>bs", show_strongs, { noremap = true, buffer = true })

vim.keymap.set("n", "<leader>lf", function()
	-- print(vim.api.nvim_win_get_cursor(0)[2])
	local s = "G245"
	print(s:sub(1, 1) == "G")
	s = s:sub(2)
	print(s)
end, { noremap = true, buffer = true })

local function get_reference_from_line(line)
	return bible_utils.parse_reference(vim.split(line, "\t")[1])
end

local function get_reference_from_current_line()
	return bible_utils.parse_reference(vim.split(vim.api.nvim_get_current_line(), "\t")[1])
end

local function copy_passage_range(bufnr, start_line, end_line)
	local selected_lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, true)
	local first_reference = get_reference_from_line(selected_lines[1])
	local last_reference = get_reference_from_line(selected_lines[#selected_lines])

	local passage_reference = bible_utils.create_passage_reference(first_reference, last_reference)
	local passage_text = ""
	for _, line in ipairs(selected_lines) do
		passage_text = passage_text .. vim.split(line, "\t")[2] .. " "
	end

	passage_text = BreakLines(passage_text, 80, "> ")
	local markdown_link = bible_utils.create_markdown_link_string(passage_reference, first_reference.book)
	local passage_to_copy = string.format("%s\n\n%s", markdown_link, passage_text)
	return passage_to_copy
end

local function flash_passage_range(bufnr, start_line, end_line)
	local namespace_id = vim.api.nvim_create_namespace("flash_passage_range")
	vim.highlight.range(bufnr, namespace_id, "IncSearch", { start_line - 1, 0 }, { end_line - 1, 20000 })
	vim.defer_fn(function()
		if vim.api.nvim_buf_is_valid(bufnr) then
			vim.api.nvim_buf_clear_namespace(bufnr, namespace_id, 0, -1)
		end
	end, 100)
end

vim.keymap.set("v", "<leader>by", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", true)
	local bufnr, start_line = unpack(vim.fn.getpos("'<"))
	local _, end_line = unpack(vim.fn.getpos("'>"))
	local passage_to_copy = copy_passage_range(bufnr, start_line, end_line)
	vim.fn.setreg('"', passage_to_copy)

	flash_passage_range(bufnr, start_line, end_line)
end, { noremap = true, buffer = true })

vim.keymap.set("n", "<leader>by", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", true)
	local bufnr = vim.api.nvim_get_current_buf()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local passage_to_copy = copy_passage_range(bufnr, current_line, current_line)

	vim.fn.setreg('"', passage_to_copy)
	flash_passage_range(bufnr, current_line, current_line)
end, { noremap = true, buffer = true })

vim.api.nvim_set_hl(0, "TranslationNote", { fg = "#dbc074", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "CrossReference", { fg = "#74c0db", bg = "none", bold = true })

local api = vim.api

local bnr = vim.fn.bufnr("%")
local ns_id = api.nvim_create_namespace("translation_notes")

local output = ""
local found_notes = require("cache").found_notes

local notes_mapping = require("cache").notes_mapping

local find_notes_for_chapter = function()
	local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
	local current_reference_obj = get_reference_from_current_line()
	local current_chatper = current_reference_obj.chapter
	local book = current_reference_obj.book
	if found_notes[book] == nil then
		found_notes[book] = {}
	end
	if found_notes[book][current_chatper] ~= nil then
		return
	end
	found_notes[book] = {}
	local command = string.format("node /home/joshu/test/sword/examples/print_kjv.js %s %s", book, current_chatper)
	vim.fn.jobstart(command, {
		on_stdout = function(_, data, _)
			for _, v in pairs(data) do
				output = output .. v
			end
		end,
		on_stderr = function(_, data, _)
			-- vim.print(data)
		end,
		on_exit = function(_, _, _)
			local json = vim.json.decode(output)
			output = ""

			local first_verse_in_chapter = current_line_num - current_reference_obj.start_verse + 1
			local line = first_verse_in_chapter
			for _, v in pairs(json) do
				local passage = v.passage
				local notes = v.notes
				for _, note in pairs(notes) do
					local col = tonumber(note.index) + #passage + 1
					local type = "0"
					if notes_mapping[line] == nil then
						notes_mapping[line] = {}
					end
					if notes_mapping[line][col] == nil then
						notes_mapping[line][col] = {}
					end
					notes_mapping[line][col] = note
					if note.explanation ~= nil then
						api.nvim_buf_set_extmark(bnr, ns_id, line - 1, col, {
							end_line = line,
							id = tonumber(line .. col .. "2"),
							virt_text = { { "*", "TranslationNote" } },
							virt_text_pos = "inline",
						})
					end
					if #note.references ~= 0 then
						api.nvim_buf_set_extmark(bnr, ns_id, line - 1, col, {
							end_line = line,
							id = tonumber(line .. col .. "1"),
							virt_text = { { "*", "CrossReference" } },
							virt_text_pos = "inline",
						})
					end
				end
				line = line + 1
			end

			found_notes[book][current_chatper] = true
		end,
	})
end

vim.keymap.set("n", "<leader>bc", function()
	local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
	local current_col = vim.api.nvim_win_get_cursor(0)[2]
	local note = notes_mapping[current_line_num][current_col]
	if note == nil then
		return
	end
	local cross_references = note.references
	-- put all the cross references in the quickfix list
	local current_reference = vim.split(vim.api.nvim_get_current_line(), "\t")[1]
	local quickfix_list = {
		{
			-- pattern = current_reference,
			col = vim.api.nvim_win_get_cursor(0)[2] + 1,
			lnum = vim.api.nvim_win_get_cursor(0)[1],
			text = vim.api.nvim_get_current_line(),
		},
	}
	local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	-- Iterate over the list of beginnings
	for _, beginning in ipairs(cross_references) do
		local ref = bible_utils.parse_reference(beginning)
		local ref_to_search = ref.book .. " " .. ref.chapter .. ":" .. ref.start_verse
		for i, line in ipairs(buf_lines) do
			if line:find("^" .. vim.pesc(ref_to_search)) then
				table.insert(quickfix_list, {
					bufnr = 0,
					lnum = i,
					col = 1,
					text = beginning .. " " .. line:sub(#ref_to_search + 2),
				})
				break
			end
		end
	end
	local title = "Cross References for " .. current_reference
	vim.fn.setqflist({}, "r", { title = title, items = quickfix_list })
	-- vim.fn.setloclist(0, {}, "r", { title = title, items = quickfix_list })

	local current_pos = vim.api.nvim_win_get_cursor(0)
	local current_win = vim.api.nvim_get_current_win()

	-- Open the quickfix window
	vim.cmd("copen")

	-- Focus back to the original window
	vim.api.nvim_set_current_win(current_win)

	-- Restore the cursor position
	vim.api.nvim_win_set_cursor(current_win, current_pos)
end, { noremap = true, buffer = true })

-- Show the translation note explanation
vim.keymap.set("n", "<leader>bn", function()
	local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
	local current_col = vim.api.nvim_win_get_cursor(0)[2]
	local note = notes_mapping[current_line_num][current_col]
	if note == nil then
		return
	end
	local explanation = note.explanation
	if explanation == nil then
		return
	end
	-- If it is short just show it in a hover, if long show it in a split window

	-- Define popup content
	local popup_content = { explanation }

	-- Create a buffer for the popup
	local popup_bufnr = vim.api.nvim_create_buf(false, true) -- No file, ephemeral

	-- Set the content of the popup buffer
	vim.api.nvim_buf_set_lines(popup_bufnr, 0, -1, false, popup_content)

	-- Get the width of the longest line in the popup content
	local width = 0
	for _, line in ipairs(popup_content) do
		width = math.max(width, #line)
	end

	-- Open the popup window
	local popup_win_id = vim.api.nvim_open_win(popup_bufnr, false, {
		relative = "cursor",
		row = 1,
		col = 0,
		width = width,
		height = #popup_content,
		style = "minimal",
		border = "rounded",
	})

	-- Close the popup when the cursor moves
	vim.cmd(string.format("autocmd CursorMoved * ++once lua vim.api.nvim_win_close(%d, true)", popup_win_id))
end, { noremap = true, buffer = true })

vim.keymap.set("n", "<leader>fn", find_notes_for_chapter, { noremap = true, buffer = true })

local target_bufnr = vim.api.nvim_get_current_buf()

-- Function to run the command after cursor is held
local function run_command_if_cursor_held()
	local initial_pos = vim.api.nvim_win_get_cursor(0)

	vim.defer_fn(function()
		local current_pos = vim.api.nvim_win_get_cursor(0)
		if initial_pos[1] == current_pos[1] and initial_pos[2] == current_pos[2] then
			-- Replace with the command you want to run
			find_notes_for_chapter()
		end
	end, 500)
end

-- Set up an autocommand for CursorMoved event in the specific buffer
vim.api.nvim_create_autocmd("CursorMoved", {
	buffer = target_bufnr,
	callback = run_command_if_cursor_held,
})

vim.keymap.set("n", "<leader>bo", function()
	local ref = vim.split(vim.api.nvim_get_current_line(), "\t")[1]
	actions.handle_passage_ref(ref)
end, { noremap = true, buffer = true })

vim.keymap.set("n", "<leader>.", function()
	-- Go to the next found note
	local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
	local current_col = vim.api.nvim_win_get_cursor(0)[2] + 1
	local t_line = nil
	local t_col = nil

	local current_line_length = #vim.api.nvim_get_current_line()
	for i = current_line_num, 10000000000, 1 do
		for j = current_col, current_line_length, 1 do
			if notes_mapping[i] == nil then
				break
			end
			if notes_mapping[i][j] ~= nil then
				t_line = i
				t_col = j
				break
			end
		end

		if t_line ~= nil then
			break
		end

		current_line_length = #vim.api.nvim_buf_get_lines(0, i, i + 1, false)[1]
		current_col = 1
	end

	if t_line == nil then
		return
	end
	vim.api.nvim_win_set_cursor(0, { t_line, t_col })
end, { noremap = true, buffer = true })

vim.keymap.set("n", "<leader>,", function()
	-- Go to the next found note
	local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
	local current_col = vim.api.nvim_win_get_cursor(0)[2] - 1
	local t_line = nil
	local t_col = nil

	for i = current_line_num, 1, -1 do
		if notes_mapping[i] ~= nil then
			for j = current_col, 1, -1 do
				if notes_mapping[i][j] ~= nil then
					t_line = i
					t_col = j
					break
				end
			end
		end

		if t_line ~= nil then
			break
		end

		current_col = #vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
	end

	vim.api.nvim_win_set_cursor(0, { t_line, t_col })
end, { noremap = true, buffer = true })
