---@diagnostic disable: undefined-global
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require('packer').startup(function()
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    use 'EdenEast/nightfox.nvim'
    use {
        'williamboman/nvim-lsp-installer',
        requires = {'neovim/nvim-lspconfig'}
    }
    use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
    -- tag = 'release' -- To use the latest release
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline', 'neovim/nvim-lspconfig', 'L3MON4D3/LuaSnip'
        }
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    use {
        'nvim-telescope/telescope-media-files.nvim',
        requires = {{'nvim-telescope/telescope.nvim'}}
    }

    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require'neogit'.setup {} end
    }
    use {'mhartington/formatter.nvim'}
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require'gitsigns'.setup {} end
    }
    use {'pwntester/octo.nvim', config = function() require'octo'.setup() end}
    use {
        "terrortylor/nvim-comment",
        require('nvim_comment').setup {operator_mapping = "<leader>nc"}
    }
    use {
        'rcarriga/nvim-notify',
        config = function() vim.notify = require 'notify' end
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup() end
    }
    use {
        'windwp/nvim-ts-autotag',
        requires = {'nvim-treesitter/nvim-treesitter'},
        config = function() require'nvim-ts-autotag'.setup() end
    }
    -- Lua
    use {"folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons"}
    use {"jose-elias-alvarez/nvim-lsp-ts-utils"}
    use {"akinsho/toggleterm.nvim"}
    use {"sheerun/vim-polyglot"}
    use "tversteeg/registers.nvim"
    use {'tpope/vim-fugitive'}
    use {"dcampos/nvim-snippy"}
    use {"dcampos/cmp-snippy"}
    use {"mfussenegger/nvim-dap"}
    use {"Pocco81/DAPInstall.nvim"}
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use {'nvim-treesitter/nvim-treesitter'}
    use {'nvim-orgmode/orgmode'}
    use {'iamcco/markdown-preview.nvim'}
    use {'axvr/zepl.vim'}
    use {"kraftwerk28/gtranslate.nvim", requires = {"nvim-lua/plenary.nvim"}}
    use {'delphinus/vim-firestore'}
end)
