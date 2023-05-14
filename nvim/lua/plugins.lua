-- Packer bootstrap
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Autoreload neovim if plugins.lua was chaged
vim.cmd([[
augroup packer_setup_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Protect call to get packer
local ok, packer = pcall(require, 'packer')
if not ok then
    vim.notify('packer is not installed')
    return
end

-- Plugin install
packer.startup({
    function(use)
        -- packer manager itself
        use { 'wbthomason/packer.nvim' }

        -- treesitter plugin
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

        -- fuzzy finder
        use { 'nvim-telescope/telescope.nvim', tag = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

        -- laguage server protocol
        use { 'neovim/nvim-lspconfig' }

        -- auto completition
        use { 'hrsh7th/nvim-cmp' }
        use { 'hrsh7th/cmp-nvim-lsp' }
        use { 'hrsh7th/cmp-nvim-lua' }
        use { 'hrsh7th/cmp-buffer' }
        use { 'hrsh7th/cmp-path' }
        use { 'onsails/lspkind.nvim' }
        use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
        use { 'williamboman/mason.nvim', run = ':MasonUpdate' }

        -- snipets support
        use { 'L3MON4D3/LuaSnip' }
        use { 'saadparwaiz1/cmp_luasnip' }

        -- color schemes
        use { 'arcticicestudio/nord-vim' } -- nord theme

        -- status line
        use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' }
        -- buffer line
        use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons' }

        -- commenting
        use { 'numToStr/Comment.nvim' }

        -- Automatically set up plugings after bootstrup
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        snapshot = vim.fn.stdpath('config') .. '/lua/snapshot'
    }
})

-- Plugin configs
require('plugin-configs.treesitter')
require('plugin-configs.lsp')
require('plugin-configs.telescope')
require('plugin-configs.lualine')
require('plugin-configs.cmp')
require('plugin-configs.bufferline')
require('plugin-configs.comment')
require('plugin-configs.mason')
