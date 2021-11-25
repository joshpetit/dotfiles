---@diagnostic disable: undefined-global
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require('packer').startup(function()
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require'nvim-tree'.setup {
                disable_netrw = true,
                hijack_netrw = false
            }
        end
    }
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

end)
