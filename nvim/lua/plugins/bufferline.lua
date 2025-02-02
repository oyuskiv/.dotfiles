return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { { 'kyazdani42/nvim-web-devicons', lazy = false } },
    lazy = false,
    config = function()
      local bufferline = require('bufferline')

      bufferline.setup {
        highlights = require("nord.plugins.bufferline").akinsho(),
        options = {
          style_preset = bufferline.style_preset.minimal,
          show_close_icon = false,
          modified_icon = '',
          separator_style = 'thin',
          always_show_bufferline = true,
          custom_filter = function(buf_number, _)
            -- ignore quick fix list
            if vim.bo[buf_number].filetype ~= 'qf' then
              return true
            end
          end,
          offsets = {
            {
              filetype = 'NvimTree',
              text = function()
                return vim.fn.getcwd()
              end,
              highlight = 'Directory',
              text_align = 'left'
            }
          },
        }
      }

      vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>',
        { noremap = true, silent = true, desc = 'delete current buffer' })

      vim.keymap.set('n', '<leader>as', bufferline.pick, { desc = 'Buffer: pick buffer' })
      vim.keymap.set('n', '<leader>ac', bufferline.close_with_pick, { desc = 'Buffer: close picked beffer' })
      vim.keymap.set('n', '<C-n>', function() bufferline.cycle(1) end, { desc = 'Buffer: next buffer' })
      vim.keymap.set('n', '<C-p>', function() bufferline.cycle(-1) end, { desc = 'Buffer: previous beffer' })

      vim.keymap.set('n', '<leader>ad',
        function()
          vim.cmd('wa')
          local active = vim.api.nvim_get_current_buf()
          local buffers = vim.api.nvim_list_bufs()
          for _, b in ipairs(buffers) do
            if 1 == vim.fn.buflisted(b) then
              if active ~= b then
                vim.api.nvim_buf_delete(b, { force = true })
              end
            end
          end
          vim.cmd('redrawtabline')
          vim.cmd('redraw')
        end,
        { desc = 'Buffer: close other buffers' })

      vim.keymap.set('n', '<leader>aD',
        function()
          vim.cmd('wa')
          local buffers = vim.api.nvim_list_bufs()
          for _, b in ipairs(buffers) do
            if 1 == vim.fn.buflisted(b) then
              vim.api.nvim_buf_delete(b, { force = true })
            end
          end
          vim.cmd('redrawtabline')
          vim.cmd('redraw')
        end,
        { desc = 'Buffer: close all buffers' })

      vim.keymap.set('n', '<leader>aq',
        function()
          local buffers = vim.api.nvim_list_bufs()
          for _, b in ipairs(buffers) do
            if vim.bo[b].filetype == 'qf' then
              vim.api.nvim_buf_delete(b, { force = true })
            end
          end
        end,
        { desc = 'Buffer: close quick fix list' })
    end
  }
}
