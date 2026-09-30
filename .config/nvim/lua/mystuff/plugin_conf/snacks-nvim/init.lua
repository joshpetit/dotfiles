require("snacks").setup({
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
	},
	-- Enable the picker module if you want to preview images inside file searches
	picker = {
		enabled = true,
	},
})
