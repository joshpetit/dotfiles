local M = {}

M.parse_reference = function(passage_ref)
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
M.create_passage_reference = function(first_reference, last_reference)
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


return M
