M = {}


local setMap = function(letter, keys, command, extraopts)
    extraopts = extraopts or {buffer = false};
    if (not extraopts.buffer) then
        vim.api.nvim_set_keymap(letter, keys, command, {noremap = true, silent = true})
    else
        local buff = vim.api.nvim_get_current_buf();
        vim.api.nvim_buf_set_keymap(buff, letter, keys, command, {noremap = true, silent= true})
    end
end


M.nmap = function(keys, command, opts)
    setMap('n', keys, command, opts);
end

M.cmap = function(keys, command, opts)
    setMap('c', keys, command, opts);
end

M.imap = function(keys, command, opts)
    setMap('i', keys, command, opts);
end

M.vmap = function(keys, command, opts)
    setMap('v', keys, command, opts);
end

M.xmap = function(keys, command, opts)
    setMap('x', keys, command, opts);
end

return M
