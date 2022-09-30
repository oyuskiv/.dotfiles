local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
    vim.notify("treesitter is not installed")
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
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
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
        "dart",
        "hcl",
    },
})

-- Setup folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
