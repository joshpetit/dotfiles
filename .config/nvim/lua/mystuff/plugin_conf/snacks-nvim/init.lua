local quotes = require("mystuff.quotes")

-- Wrap text to a max width, breaking on spaces.
local function wrap(text, width)
	local lines = {}
	local line = ""
	for word in text:gmatch("%S+") do
		if #line + #word + 1 > width and line ~= "" then
			table.insert(lines, line)
			line = word
		else
			line = (line == "") and word or (line .. " " .. word)
		end
	end
	if line ~= "" then
		table.insert(lines, line)
	end
	return lines
end

local quote_text, quote_author = quotes.random()

require("snacks").setup({
	dashboard = {
		enabled = true,
		sections = {
			function()
				local width = math.max(20, math.min(vim.o.columns - 4, 80))
				local text = table.concat(wrap('"' .. quote_text .. '"', width), "\n")
				return {
					padding = 2,
					align = "center",
					text = {
						{ text, hl = "SnacksDashboardHeader" },
						{ "\n\n" },
						{ "— " .. quote_author, hl = "SnacksDashboardSpecial" },
					},
				}
			end,
		},
	},
	-- Enable the image module configuration
	image = {
		enabled = true,
		-- Optional: customize supported extensions if needed
		formats = {
			"png",
			"jpg",
			"jpeg",
			"gif",
			"bmp",
			"webp",
			"avif",
			"mp4",
			"pdf",
		},
		-- img_dirs are relative to cwd/file dir, so resolve absolute dirs here
		resolve = function(_, src)
			local wiki = vim.fn.expand("~/sync/wiki") .. "/" .. src
			if vim.fn.filereadable(wiki) == 1 then
				return wiki
			end
		end,
	},
	-- Enable the picker module if you want to preview images inside file searches
	picker = {
		enabled = true,
	},
})
