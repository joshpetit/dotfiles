-- TODO create pcall wrapper to do error handling and let other things be
-- sourced
require("mystuff/utils")

vim.opt.termguicolors = true
Jcall(require, "mystuff/plugins")
Jcall(require, "mystuff/settings")
Jcall(require, "mystuff/mappings")
Jcall(require, "mystuff/work")
