---@diagnostic disable: undefined-global
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- local fn = vim.fn
local fn = vim.fn
local PLUGIN_CONF_PATH = fn.stdpath("config") .. "/lua/mystuff/plugin_conf/"
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end
return require("packer").startup(function()
    local use_help = function(params, create_config)
        local plugin = params[1]
        local requires = params.requires
        local config = params.config
        use({ plugin, requires = requires, config = config, disable = params.disable })
        if create_config then
            local split = SplitString(plugin, "/")
            local plugin_name = split[GetLastIndex(split)]
            plugin_name = plugin_name:gsub("%.", "-")
            local plugin_dir = PLUGIN_CONF_PATH .. plugin_name .. "/"
            local dir_exists = FileExists(plugin_dir)
            if not dir_exists then
                os.execute("mkdir -p " .. plugin_dir)
            end
            local init_file = plugin_dir .. "init.lua"
            local init_exist = FileExists(init_file)
            if not init_exist then
                os.execute("touch " .. init_file)
            end
            require("mystuff/plugin_conf/" .. plugin_name)
        end
    end

    use("wbthomason/packer.nvim")
    use_help({
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        disable = false,
    }, true)
    use({
        "EdenEast/nightfox.nvim",
        config = function()
            require("mystuff/settings")["nightfox"]()
        end,
    })
    -- use {'~/projects/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
    use({
        "akinsho/flutter-tools.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    -- tag = 'release' -- To use the latest release
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "neovim/nvim-lspconfig",
            "dcampos/nvim-snippy",
            "dcampos/cmp-snippy",
        },
    })
    use_help({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    }, true)

    use_help({ "mhartington/formatter.nvim" }, true)
    -- Git diffs on the column
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup({})
        end,
    })
    use({
        "pwntester/octo.nvim",
        config = function()
            require("octo").setup()
        end,
        disable = true,
    })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })
    use({
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })
    use({
        "windwp/nvim-ts-autotag",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    })
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
        end,
    })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
    use({ "tpope/vim-fugitive" })
    use_help({ "dcampos/nvim-snippy" }, true)
    use({ "mfussenegger/nvim-dap" })
    use({
        "williamboman/nvim-lsp-installer",
        requires = { "neovim/nvim-lspconfig" },
    })
    use_help({
        "neovim/nvim-lspconfig",
    }, true)
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end,
    })
    use_help({ "nvim-treesitter/nvim-treesitter" }, true)
    use_help({
        "nvim-orgmode/orgmode",
    }, true)
    -- use({
    -- 	"~/projects/orgmode",
    -- 	config = function()
    -- 		require("mystuff/settings")["orgmode"]()
    -- 	end,
    -- })
    use({ "iamcco/markdown-preview.nvim" })
    -- use {'axvr/zepl.vim'}
    use({ "kraftwerk28/gtranslate.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use({ "delphinus/vim-firestore" })
    use({ "stevearc/dressing.nvim" })
    -- Gets a little annoying
    use({ "ray-x/lsp_signature.nvim" })
    use({ "simrat39/symbols-outline.nvim" })
    use("folke/lua-dev.nvim")
    -- F11, focused mode!
    use("Pocco81/TrueZen.nvim")
    -- Make vim start faster!
    -- use {
    --     'lewis6991/impatient.nvim',
    --     config = function() require('impatient') end
    -- }
    -- use {"vuki656/package-info.nvim", requires = "MunifTanjim/nui.nvim"}
    use({ "lervag/vimtex" })
    -- use {"jamestthompson3/nvim-remote-containers"}
    use({ "vim-test/vim-test" })
    use({ "tpope/vim-dispatch" })
    use({
        "rcarriga/vim-ultest",
        requires = { "vim-test/vim-test" },
        run = ":UpdateRemotePlugins",
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("tpope/vim-eunuch") -- SudoWrite!
    --use 'junegunn/fzf.vim'
    use("BurntSushi/ripgrep")
    -- \rf=Start R
    -- \pp to send paragraph
    -- \rm to remove previous output
    -- \kr to produce rmarkdown as html and open in browser
    use({
        "jalvesaq/nvim-r",
        config = function()
            require("mystuff/settings")["nvim-r"]()
        end,
    })
    use("tpope/vim-rhubarb")
    use("shumphrey/fugitive-gitlab.vim")
    use("nvim-treesitter/playground")
    use_help({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    }, true)
    use({
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({})
        end,
    })
    use("mechatroner/rainbow_csv")
    use("chrisbra/csv.vim")
    use({
        "weirongxu/plantuml-previewer.vim",
        requires = { "tyru/open-browser.vim", "aklt/plantuml-syntax" },
    })
    use("ferrine/md-img-paste.vim")
    use("godlygeek/tabular")
    use("tpope/vim-abolish")
    use("jbyuki/nabla.nvim")
    use({ "ThePrimeagen/harpoon" })
    use({
        "kwkarlwang/bufresize.nvim",
        config = function()
            require("bufresize").setup()
        end,
    })
    use({ "aymericbeaumet/vim-symlink", requires = "moll/vim-bbye" })

    if Packer_bootstrap then
        require("packer").sync()
    end
end)
