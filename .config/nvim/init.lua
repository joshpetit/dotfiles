-- TODO create pcall wrapper to do error handling and let other things be
-- sourced
require("mystuff/utils")
vim.g.maplocalleader = "<C-S>"
require("config.lazy")
Jcall(require, "mystuff/mappings")


vim.opt.termguicolors = true
Jcall(require, "mystuff/settings")

if IsModuleAvailable('work') then
    Jcall(require, "work")
end
