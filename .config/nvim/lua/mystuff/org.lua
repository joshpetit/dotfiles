local actions = require "telescope.actions"
local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"

M = {}

local save_position = function()
    local line = vim.fn.line('.');
    local col = vim.fn.col('.');
    return {line, col};
end

local load_position = function(position) vim.fn.cursor(position); end

local goToHeading = function() vim.fn.search([[^\* ]], 'bW') end

local goToProperty = function(prop) vim.fn.search(':' .. prop .. ':', 'eW') end

M.goToZoom = function()
    local pos = save_position();
    goToHeading()
    --local res = vim.api.nvim_exec([[g/^\* /p]], true);
    --print(res);

  --   pickers.new({
  --   prompt_title = "Classes to zoom from",
  --   finder = finders.new_table {
  --     results = acceptable_files,
  --     entry_maker = function(line)
  --     end,
  --   },
  --   attach_mappings = function(prompt_bufnr)
  --     actions.select_default:replace(function()
  --       local selection = action_state.get_selected_entry()
  --       if selection == nil then
  --         print "[telescope] Nothing currently selected"
  --         return
  --       end
  --
  --       actions.close(prompt_bufnr)
  --       print("Enjoy astronomy! You viewed:", selection.display)
  --     end)
  --
  --     return true
  --   end,
  -- }):find();

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
