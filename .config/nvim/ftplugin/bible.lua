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
	local diatheke_output = vim.fn.system("diatheke -b NASB -o n -k " .. reference)
	local last_lemma

	for i, word in ipairs(words_split) do
		local next_lemma_position = diatheke_output:find('lemma="strong:')
		local word_position_in_output = diatheke_output:find(word)
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

	local is_hebrew = last_lemma:sub(1, 1) == "H"
	local lemma = last_lemma:sub(2)
	local strongs_output
	print(lemma)
	if is_hebrew then
		print("diatheke -b StrongsHebrew -k " .. lemma)
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
