local actions = require("my_px.swift")

vim.keymap.set("n", "<leader><leader>w", actions.wrap_in_vstack)

vim.keymap.set("n", "<leader><leader>apt", function()
	actions.add_modifier("padding", ".top", 4)
end)

vim.keymap.set("n", "<leader><leader>apb", function()
	actions.add_modifier("padding", ".bottom", 4)
end)

vim.keymap.set("n", "<leader><leader>aph", function()
	actions.add_modifier("padding", ".horizontal", 4)
end)

vim.keymap.set("n", "<leader><leader>af", function()
	actions.add_modifier("font", ".")
end)

vim.keymap.set("n", "<leader><leader>ec", function()
	actions.extract_component()
end)

-- Extract to field
vim.keymap.set("n", "<leader><leader>etf", function()
	actions.extract_variable_to_struct()
end)


-- if not null_ls.is_registered("swift-actions") then
-- 	require("null-ls").register({
-- 		name = "swift-actions",
-- 		method = { require("null-ls").methods.CODE_ACTION },
-- 		filetypes = { "swift" },
-- 	})
--
-- 	require("null-ls").register({
-- 		name = "swift-actions",
-- 		method = { require("null-ls").methods.CODE_ACTION },
-- 		filetypes = { "swift" },
-- 	})
-- end

