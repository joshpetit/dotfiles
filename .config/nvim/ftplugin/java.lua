local jdtls = require("jdtls")
local on_attach = require("mystuff/on_attach_conf")

local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local ws_folders_jdtls = {}
if root_dir then
 local file = io.open(root_dir .. "/.bemol/ws_root_folders")
 if file then
  for line in file:lines() do
   table.insert(ws_folders_jdtls, "file://" .. line)
  end
  file:close()
 end
end

local config = {
 on_attach = on_attach,
 cmd = {
  "jdtls", -- need to be on your PATH
  "--jvm-arg=-javaagent:" .. home .. "/apps/lombok.jar", -- need for lombok magic
  "-data",
  eclipse_workspace,
 },
 root_dir = root_dir,
 init_options = {
  workspaceFolders = ws_folders_jdtls,
 },
}

jdtls.start_or_attach(config)
