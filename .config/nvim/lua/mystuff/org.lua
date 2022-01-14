local actions = require "telescope.actions"
local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

M = {}

local save_position = function()
    local line = vim.fn.line('.');
    local col = vim.fn.col('.');
    return {line, col};
end

local load_position = function(position) vim.fn.cursor(position); end

local goToHeading = function() vim.fn.search([[^\* ]], 'bW') end

local goToProperty = function(prop) vim.fn.search(':' .. prop .. ':', 'eW') end

M.goToHeading = function()
    vim.cmd([[vim /^\* / %]])
    require('telescope.builtin').quickfix({});
end

M.goToHomework = function()
    vim.cmd([[vim /:homework:.*\_.\{-}\*\*\* \zs.*\ze/ %]])
    require('telescope.builtin').quickfix({});
end

M.goToZoom = function()
    local pos = save_position();
    goToHeading()
    goToProperty('zoom');
    vim.cmd([[normal Wgx]])
    load_position(pos);
end

M.goToSite = function()
    local pos = save_position();
    goToHeading()
    goToProperty('site')
    vim.cmd([[normal Wgx]])
    load_position(pos);
end

M.goToNotes = function()
    goToHeading()
    vim.fn.search([[\** Notes]], 'W')
    -- TODO: If no notes found create subheading
end

return M;

-- Example of way to do picker
-- pickers.new({}, {
--     prompt_title = "Find Files",
--     finder = require("telescope.finders").new_table({
--         results = {"sup", "my", "dude"}
--     }),
--     sorter = require("telescope.config").values.generic_sorter({})
-- }):find()
--
-- Regex to find a property
-- ^\* .*\_.\{-}:zoom:\s*\zs.*
