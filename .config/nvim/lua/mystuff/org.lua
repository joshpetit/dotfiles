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
