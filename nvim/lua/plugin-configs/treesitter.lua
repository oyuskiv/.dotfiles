local ok, treesitter = pcall(require, 'nvim-treesitter.config')
if not ok then
    return
end

treesitter.setup({
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  incremental_selection = {
    enable = true
  },
  textobjects = {
    enable = true
  },
  ensure_installed = {
    "bash",
    "toml",
    "json",
    "yaml",
    "python",
    "lua",
    "c",
    "cpp",
    "cmake",
    "make",
    "dockerfile",
    "go",
    "gomod",
    "vim",
    "rust",
    "bash",
    "markdown",
    "java",
    "javascript",
    "dart"
  },
})

-- Setup folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
