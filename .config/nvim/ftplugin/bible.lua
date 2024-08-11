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

vim.keymap.set("n", "<Localleader>gw", show_strongss, { noremap = true })
vim.keymap.set("n", "<leader>lf", function()
	-- print(vim.api.nvim_win_get_cursor(0)[2])
	local s = "G245"
	print(s:sub(1, 1) == "G")
	s = s:sub(2)
	print(s)
end, { noremap = true })

-- make a function to call show_strongs every time the cursor moves
-- vim.cmd(
-- 	[[
--         autocmd CursorMoved *.bible lua show_strongss()
--     ]],
-- 	false
-- )
