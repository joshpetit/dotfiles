local h = require("my_px.helpers")

local M = {}

---@param node TSNode
local iterate_till_hit_tag = function(node)
	while node ~= nil and not (node:type() == "start_tag" or node:type() == "end_tag") do
		node = node:parent()
		vim.pretty_print(h.get_node_text(node))
	end
    vim.pretty_print("MADE IT")
	return node
end

---@param current_tag TSNode
local find_other_tag = function(current_tag)
	local parent = current_tag:parent()
	for _, node in parent:iter_children() do
		vim.pretty_print(h.get_node_text(node))
	end
end

M.jump_to_other_tag = function()
	local current_node = h.get_current_node()
    if(current_node == nil) then
        print('it didnt work lol')
        return
    end
	local current_tag = iterate_till_hit_tag(current_node)
    find_other_tag(current_tag)
end

return M
