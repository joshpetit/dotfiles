require("nvim-treesitter.configs").setup({ autotag = { enable = true } })

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.puml = {
    install_info = {
        url = "https://github.com/ahlinc/tree-sitter-plantuml",
        revision = "demo",
        files = { "src/scanner.cc" },
    },
    filetype = "puml",
}
parser_config.md = {
    install_info = {
        url = "https://github.com/ikatyang/tree-sitter-markdown",
        revision = "master",
        files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "markdown",
}
