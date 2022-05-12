local prettierFormatter = {
    -- prettier
    function()
        return {
            exe = "prettier",
            args = {
                "--stdin-filepath",
                vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                "--single-quote",
            },
            stdin = true,
        }
    end,
}

require("formatter").setup({
    filetype = {
        jsonc = prettierFormatter,
        markdown = prettierFormatter,
        ["creole.markdown"] = prettierFormatter,
        lua = {
            -- luafmt
            function()
                return { exe = "stylua", stdin = true, args = { "-" } }
            end,
        },
        dart = {
            -- Shell Script Formatter
            function()
                return { exe = "dart", args = { "format" }, stdin = true }
            end,
        },
        -- org = {
        --     -- Shell Script Formatter
        --     function()
        --         return {exe = "go-org", args = {"render org"}, stdin = true}
        --     end
        -- },
        racket = {
            -- Shell Script Formatter
            function()
                return { exe = "raco ", args = { "fmt", "--width 80" }, stdin = true }
            end,
        },
    },
})
