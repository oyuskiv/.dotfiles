return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter = require('nvim-treesitter.configs')
      treesitter.setup({
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = {
          enable = true,
          disable = { "dart" }, -- https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
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
        sync_install = true,
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
          "http",
        },
      })

      -- Setup folding
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldlevel = 99
    end
  }
}
