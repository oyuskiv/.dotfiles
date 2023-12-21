return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { { 'kyazdani42/nvim-web-devicons' } },
    config = function()
      local api = require('nvim-tree.api')
      require('nvim-tree').setup({
        sort_by = 'case_sensitive',
        view = {
          side = 'right',
          width = 40,
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              git = false,
            },
          },
        },
        filters = {
          dotfiles = true,
        },
      })

      vim.keymap.set('n', '<leader>t', api.tree.toggle, { desc = 'NvimTree: toogle' })
    end
  }
}
