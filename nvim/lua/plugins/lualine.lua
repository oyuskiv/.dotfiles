return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
      { 'kyazdani42/nvim-web-devicons', lazy = false },
      { 'SmiteshP/nvim-navic' },
    },
    config = function()
      local lualine = require('lualine')
      local navic = require('nvim-navic')
      lualine.setup {
        options = {
          icons_enabled = true,
          theme = 'nord',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {
              'dap-repl',
              'dapui_console',
              'dapui_watches',
              'dapui_stacks',
              'dapui_breakpoints',
              'dapui_scopes',
            },
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            'diff',
            {
              'diagnostics',
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            },
          },
          lualine_c = {},
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {
          lualine_b = {
            {
              'filename',
              path = 1
            },
          },
          lualine_c = {
            {
              function()
                if navic.is_available() then
                  return navic.get_location()
                else
                  return ''
                end
              end
            },
          },
        },
        inactive_winbar = {},
        extensions = { 'quickfix', 'nvim-tree', 'nvim-dap-ui' }
      }
    end
  }
}
