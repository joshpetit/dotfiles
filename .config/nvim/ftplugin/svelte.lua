local actions = require("my_px.svelte")
vim.b.match_words =
	[[<!--:-->,<:>,<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,<\@<=\([^/!][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\([^/!][^ \t>]*\)>,(:),{:},\[:\],<:>,\/\*:\*\/,#\s*if\%(n\=def\)\=:#\s*else\>:#\s*elif\>:#\s*endif\>]]

vim.keymap.set("n", "%", function()
	local successful = pcall(actions.jump_to_other_tag)
	if not successful then
        print('you suck')
		vim.cmd("normal! %")
	end
end)
