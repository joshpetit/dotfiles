local get_start_of_word_at_cursor = function()
	local cur_pos = vim.api.nvim_win_get_cursor(0)
	-- jump to beginning of word under cursor
	-- b: backward
	-- c: accept match right under cursor
	vim.fn.search(vim.fn.expand("<cword>"), "bc")
	local new_pos = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_win_set_cursor(0, cur_pos)
	-- zero-indexed, add 1 as example indicates 1 indexing
	local result = new_pos[2]
	return result
end

local show_strongs = function()
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		-- relative = "editor",
		-- width = 80,
		-- height = 20,
		row = 10,
		col = 10,
		-- style = "minimal",
	})
	-- Don't make it a floating window
end

local show_strongss = function()
	-- Create a new split window
	local original_window = vim.api.nvim_get_current_win()
	-- see if the buffer strongs buff already exists
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
	local start_word_at_cursor = get_start_of_word_at_cursor()
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

vim.keymap.set("n", "<Localleader>gw", show_strongss, { noremap = true, buffer = true })
vim.keymap.set("n", "<leader>lf", function()
	-- print(vim.api.nvim_win_get_cursor(0)[2])
	local s = "G245"
	print(s:sub(1, 1) == "G")
	s = s:sub(2)
	print(s)
end, { noremap = true, buffer = true })

-- make a function to call show_strongs every time the cursor moves
-- vim.cmd(
-- 	[[
--         autocmd CursorMoved *.bible lua show_strongss()
--     ]],
-- 	false
-- )

local function parse_reference(passage_ref)
	local version = "NASB"
	local book = passage_ref:match("%d*[%a%s]+%a")
	local numbers = passage_ref:gsub(book, "")
	local chapter = numbers:match("%d+")
	local verses = numbers:match(":%d+")
	local start_verse
	local end_verse

	if verses ~= nil then
		start_verse = verses:match("%d+")
		local end_verse_part = numbers:match("-%d+")
		if end_verse_part ~= nil then
			end_verse = end_verse_part:match("%d+")
		end
	end

	local parsed_version = passage_ref:gsub(book, ""):match("%a+")
	if parsed_version ~= nil then
		version = parsed_version
		passage_ref = vim.trim(passage_ref:gsub(parsed_version, ""))
	end
	return {
		passage_ref = passage_ref,
		book = book,
		chapter = chapter,
		start_verse = start_verse,
		end_verse = end_verse,
		version = version,
	}
end

-- Thank you AI!
local create_passage_reference = function(first_reference, last_reference)
	local passage_reference = ""
	if first_reference.book == last_reference.book then
		passage_reference = first_reference.book
		if first_reference.chapter == last_reference.chapter then
			passage_reference = passage_reference .. " " .. first_reference.chapter
			if first_reference.start_verse == last_reference.start_verse then
				passage_reference = passage_reference .. ":" .. first_reference.start_verse
				if first_reference.end_verse ~= nil then
					passage_reference = passage_reference .. "-" .. last_reference.end_verse
				end
			else
				passage_reference = passage_reference .. ":" .. first_reference.start_verse
				if first_reference.end_verse ~= nil then
					passage_reference = passage_reference .. "-" .. first_reference.end_verse
				end
				passage_reference = passage_reference .. "-" .. last_reference.start_verse
				if last_reference.end_verse ~= nil then
					passage_reference = passage_reference .. "-" .. last_reference.end_verse
				end
			end
		else
			passage_reference = passage_reference
				.. " "
				.. first_reference.chapter
				.. ":"
				.. first_reference.start_verse
			if first_reference.end_verse ~= nil then
				passage_reference = passage_reference .. "-" .. first_reference.end_verse
			end
			passage_reference = passage_reference .. "-" .. last_reference.chapter .. ":" .. last_reference.start_verse
			if last_reference.end_verse ~= nil then
				passage_reference = passage_reference .. "-" .. last_reference.end_verse
			end
		end
	else
		passage_reference = first_reference.book .. " " .. first_reference.chapter .. ":" .. first_reference.start_verse
		if first_reference.end_verse ~= nil then
			passage_reference = passage_reference .. "-" .. first_reference.end_verse
		end
		passage_reference = passage_reference
			.. "-"
			.. last_reference.book
			.. " "
			.. last_reference.chapter
			.. ":"
			.. last_reference.start_verse
		if last_reference.end_verse ~= nil then
			passage_reference = passage_reference .. "-" .. last_reference.end_verse
		end
	end
	return passage_reference
end

local function break_lines(text, max_width, prefix)
	prefix = prefix or ""
	max_width = max_width or 80
	local result = {}
	local line = ""

	for word in text:gmatch("%S+") do
		if #line + #word + #prefix + 1 > max_width then
			table.insert(result, prefix .. line)
			line = word
		else
			line = (line ~= "") and line .. " " .. word or word
		end
	end
	table.insert(result, prefix .. line)

	return table.concat(result, "\n")
end

vim.keymap.set("v", "ge", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", true)
	local bufnum, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
	local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))
	local selected_lines = vim.api.nvim_buf_get_lines(bufnum, start_line - 1, end_line, true)
	-- TODO: Make it partially select the passage

	local first_reference = parse_reference(vim.split(selected_lines[1], "\t")[1])
	local last_reference = parse_reference(vim.split(selected_lines[#selected_lines], "\t")[1])
	local passage_reference = create_passage_reference(first_reference, last_reference)
	local passage_text = ""
	for _, line in ipairs(selected_lines) do
		passage_text = passage_text .. vim.split(line, "\t")[2] .. " "
	end

	passage_text = break_lines(passage_text, 80, "> ")
	local markdown_link = string.format("[bible:%s](%s)", passage_reference, first_reference.book)
	local passage_to_copy = string.format("%s\n\n%s", markdown_link, passage_text)
	vim.fn.setreg('"', passage_to_copy)
end, { noremap = true, buffer = true })

-- Define a function to highlight a specific word
local function highlight_word(bufnr, line_num, word_index, hl_group)
	-- Check if the buffer number is valid
	if not vim.api.nvim_buf_is_valid(bufnr) then
		print("Invalid buffer number")
		return
	end

	-- Get the line content
	local line = vim.api.nvim_buf_get_lines(bufnr, line_num - 1, line_num, false)[1]

	-- Split the line into words
	local words = vim.split(line, "%s+", { trimempty = true })

	-- Check if the word index is within range
	if word_index > #words then
		print("Word index out of range")
		return
	end

	-- Get the word to be highlighted
	local word = words[word_index]
	local start_col = string.find(line, word, 1, true)
	local end_col = start_col + #word

	-- Apply the highlight
	vim.api.nvim_buf_add_highlight(bufnr, -1, hl_group, line_num - 1, start_col - 1, end_col - 1)
end

-- Define highlight group
-- vim.api.nvim_set_hl(0, "Identifier", { fg = "red", bg = "none", bold = false })
vim.api.nvim_set_hl(0, "TranslationNote", { fg = "#dbc074", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "CrossReference", { fg = "#74c0db", bg = "none", bold = true })

-- Highlight the 5th word on the 10th line
highlight_word(0, 10, 5, "CrossReferences")
highlight_word(0, 10, 5, "Identifier")

local api = vim.api

local bnr = vim.fn.bufnr("%")
local ns_id = api.nvim_create_namespace("translation_notes")

local output = ""
local found_notes = {}

local notes_mapping = {}

find_notes_for_chapter = function()
	local current_line = vim.api.nvim_get_current_line()
	local current_reference = vim.split(current_line, "\t")[1]
	local current_reference_obj = parse_reference(current_reference)
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
			for k, v in pairs(data) do
				output = output .. v
			end
		end,
		on_stderr = function(_, data, _)
			-- print(data)
		end,
		on_exit = function(_, code, _)
			local json = vim.json.decode(output)
			output = ""
			-- TODO Fix offset later
			local offset = 0
			-- find the line the first verse in the chapter is on
			local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
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
		local ref = parse_reference(beginning)
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

-- Probably will use this  https://github.com/junegunn/vim-easy-align
-- set the local buffer to be unmodifiable
vim.bo[0].modifiable = false

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

vim.wo[0].cursorline = true

local actions = require("mystuff.bible_actions")

vim.keymap.set("n", "<leader>bo", function()
	local ref = vim.split(vim.api.nvim_get_current_line(), "\t")[1]
	actions.handle_passage_ref(ref)
end, { noremap = true, buffer = true })
