local h = require("my_px.helpers")
local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

---@param node TSNode
local iterate_till_hit_tag = function(node)
	while node ~= nil and not (node:type() == "start_tag" or node:type() == "end_tag") do
		node = node:parent()
	end
	return node
end

---@param current_tag TSNode
local find_other_tag = function(current_tag)
	local parent = current_tag:parent()
	local current_tag_type = current_tag:type()
	vim.print(parent:child_count())
	for node, _ in parent:iter_children() do
		local this_tag_type = node:type()
        if (this_tag_type == 'start_tag' or this_tag_type == 'end_tag') and this_tag_type ~= current_tag_type then
            return node
        end
	end
end

M.jump_to_other_tag = function()
	local current_node = h.get_current_node()
	local current_tag = iterate_till_hit_tag(current_node)
	local other_tag = find_other_tag(current_tag)
    ts_utils.goto_node(other_tag)
end

return M
