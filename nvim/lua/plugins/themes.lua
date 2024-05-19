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
    end,
  },
}
