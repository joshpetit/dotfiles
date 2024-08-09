--[[
Remove all subtrees whose headlines contain class `noexport`.
License:   MIT
Copyright: © Albert Krewinkel
]]

-- pandoc.utils.make_sections exists since pandoc 2.8
PANDOC_VERSION:must_be_at_least({ 2, 8 })

local utils = require("pandoc.utils")

-- Returns true iff a div is a section div.
local function is_section_div(div)
	return div.t == "Div" and div.classes[1] == "section" and div.attributes.number
end

-- Returns the header element of a section, or nil if the argument is not a
-- section.
local function section_header(div)
	if not div.t == "Div" then
		return nil
	end
	local header = div.content and div.content[1]
	local is_header = is_section_div(div) and header and header.t == "Header"
	return is_header and header or nil
end

--- Remove remaining section divs
local function flatten_sections(div)
	local header = section_header(div)
	if not header then
		return nil
	else
		header.identifier = div.identifier
		div.content[1] = header
		return div.content
	end
end

function drop_noexport_sections(div)
	if div.classes:includes("noexport") then
		return {}
	end
end

--- Setup the document for further processing by wrapping all
--- sections in Div elements.
function setup_document(doc)
	local sections = utils.make_sections(false, nil, doc.blocks)
	return pandoc.Pandoc(sections, doc.meta)
end

-- [bible:John 3:15 NKJV](John)
function do_it(link)
    if link.content[1] == nil then
        return link
    end
    local first_string = link.content[1].text
    if first_string:match("bible:") == nil then
        return link
    end
    local passage_ref = first_string:match(":%w+"):gsub(":", "")
    for i = 2, #link.content do
        if link.content[i].text ~= nil then
            passage_ref = passage_ref .. " " .. link.content[i].text
        end
    end
    local version = "ESV"

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
		passage_ref = passage_ref:gsub(parsed_version, "")
	end
    link.content = { pandoc.Strong(passage_ref .. " (" .. version .. ")") }
    link.target = "https://www.biblegateway.com/passage/?search=" .. passage_ref .. "&version=" .. version

    return pandoc.Strong(link)
end

return {
	{ Pandoc = setup_document },
	{ Div = drop_noexport_sections },
	{ Div = flatten_sections },
	{ Link = do_it },
}
