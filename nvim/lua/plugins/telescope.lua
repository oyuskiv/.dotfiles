return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },
  {
    'oyuskiv/telescope-dap.nvim',
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'oyuskiv/telescope-dap.nvim',
    },
    lazy = false,
    config = function()
      local telescope = require('telescope')
      telescope.setup {
        defaults = {
          sorting_strategy = 'ascending',
          layout_config = {
            prompt_position = 'top',
            height = 0.90,
            width = 0.95
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = 'smart_case',       -- or 'ignore_case' or 'respect_case'
          },
          ['ui-select'] = {
            require('telescope.themes').get_cursor()
          },
          dap = {
            dap_ui = require('telescope.themes').get_dropdown()
          }
        }
      }

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('dap')
      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('flutter')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ follow = true }) end,
        { desc = 'Telescope: find files' })
      vim.keymap.set('n', '<leader>fF',
        function()
          builtin.find_files({ follow = true, no_ignore = true, hidden = true })
        end,
        { desc = 'Telescope: find files no ignore/hidden' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: live grep' })
      vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Telescope: grep string' })
      vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find,
        { desc = 'Telescope: buffer fuzzy find' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: select buffer' })
      vim.keymap.set('n', '<leader>fd',
        function()
          builtin.lsp_document_symbols({ show_line = true })
        end,
        { desc = 'Telescope: document symbols' })
    end
  }
}
