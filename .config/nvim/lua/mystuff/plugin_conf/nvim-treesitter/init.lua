require("nvim-treesitter.configs").setup(
{
    autotag = {
        enable = true 
    },
    highlight = {
        enable = true
    }
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.puml = {
    install_info = {
        url = "https://github.com/ahlinc/tree-sitter-plantuml",
        revision = "demo",
        files = { "src/scanner.cc" },
    },
    filetype = "puml",
}
