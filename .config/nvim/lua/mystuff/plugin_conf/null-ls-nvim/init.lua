-- R markdown
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

local stylermd = h.make_builtin({
    name = "stylermd",
    method = { FORMATTING },
    filetypes = { "rmd" },
    generator_opts = {
        command = "R",
        args = h.range_formatting_args_factory({
            "--slave",
            "--no-restore",
            "--no-save",
            "-e",
            [[
        options(styler.quiet = TRUE)
        con <- file("stdin")
        temp <- tempfile("styler", fileext = ".Rmd")
        writeLines(readLines(con), temp)
        styler::style_file(temp)
        output <- paste0(readLines(temp), collapse = '\n')
        cat(output)
        close(con)
      ]]     ,
        }, "--range-start", "--range-end", { row_offset = -1, col_offset = -1 }),
        to_stdin = true,
    },
    factory = h.formatter_factory,
})
-- End R markdown
--
null_ls.setup({
    debug = true,
    default_timeout = 5000,
    sources = {
        -- Make builtin styler works with R file only
        formatting.styler.with({
            filetypes = { "r" },
        }),
        stylermd,
        require("null-ls").builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
            extra_filetypes = { "toml" },
        }),
        null_ls.builtins.formatting.google_java_format,
    },
})
