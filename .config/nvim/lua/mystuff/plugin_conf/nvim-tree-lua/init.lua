local lib = require("nvim-tree.lib")
function OpenNvimTreeFile()
	local node = lib.get_node_at_cursor()
	AsyncRun("dragon-drag-and-drop", node.absolute_path)
	print(node.absolute_path)
end

require("nvim-tree").setup({
	update_cwd = true,
	--update_focused_file = { enable = true, update_cwd = true },
	disable_netrw = false,
	hijack_netrw = false,
	view = {
		relativenumber = true,
		width = 40,
		mappings = {
			custom_only = false,
			list = {
				{ key = { "D" }, cb = "<cmd>lua print(OpenNvimTreeFile())<cr>" },
			},
		},
	},
})
