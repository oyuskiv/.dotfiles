return {
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").setup({})
      vim.cmd.colorscheme("nord")
      -- override line numbers
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#A3B1C2" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#EBCB8B", bold = true })
      vim.api.nvim_set_hl(0, "SignColumn", { fg = "#A3B1C2", bg = "#2E3440" })
    end,
  },
}
