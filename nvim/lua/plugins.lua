-- Packer bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

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
packer.startup(function(use)
    use { 'wbthomason/packer.nvim' } -- packer manage itself
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- treesitter plugin
    use { 'neovim/nvim-lspconfig' } -- laguage server protocol
    use { 'fatih/vim-go', run = ':GoInstallBinaries' } -- golang support
    use { 'nvim-telescope/telescope.nvim', -- fuzzy finder
        requires = { 'nvim-lua/plenary.nvim' } }

    -- color schemes
    use { 'arcticicestudio/nord-vim' } -- nord theme

    -- Automatically set up plugings after bootstrup
    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Plugin configs
require('plugin-configs.treesitter')
require('plugin-configs.lsp')
require('plugin-configs.telescope')
