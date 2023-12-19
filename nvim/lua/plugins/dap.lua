return {
  {
    'mfussenegger/nvim-dap',
    tag = '0.7.0',
    config = function()
      local dap = require('dap')
      vim.keymap.set('n', '<Leader>dc', function() dap.continue() end, { desc = 'DAP: continue' })

      vim.keymap.set('n', '<Leader>dC', function()
          dap.terminate()
          dap.run_last()
        end,
        { desc = 'DAP: restart' })

      vim.keymap.set('n', '<Leader>do', function() dap.step_over() end, { desc = 'DAP: step over' })
      vim.keymap.set('n', '<Leader>di', function() dap.step_into() end, { desc = 'DAP: step into' })
      vim.keymap.set('n', '<Leader>dO', function() dap.step_out() end, { desc = 'DAP: step out' })
      vim.keymap.set('n', '<Leader>dt', function() dap.terminate() end,
        { desc = 'DAP: terminate' })
      vim.keymap.set('n', '<Leader>dT', function() dap.disconnect({ terminateDebuggee = false }) end,
        { desc = 'DAP: disconnect' })

      vim.keymap.set('n', '<Leader>db',
        function()
          dap.toggle_breakpoint()
          require('dapui').elements.breakpoints.render()
        end, { desc = 'DAP: toogle breakpoint' })

      vim.keymap.set('n', '<Leader>dB',
        function()
          dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
          require('dapui').elements.breakpoints.render()
        end,
        { desc = 'DAP: set condition breakpoint' }
      )

      vim.keymap.set('n', '<Leader>dl', function() require('telescope').extensions.dap.list_breakpoints() end,
        { desc = 'DAP: list breakpoints' })
      vim.keymap.set('n', '<Leader>dL', function() dap.clear_breakpoints() end, { desc = 'DAP: clear breakpoints' })

      vim.keymap.set('n', '<Leader>dp',
        function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        { desc = 'DAP: set log point (breakpoint)' }
      )

      vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = 'DAP: open repl' })

      local widgets = require('dap.ui.widgets')
      vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function() widgets.hover() end, { desc = 'DAP: hover widget' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function() widgets.preview() end, { desc = 'DAP: preview widget' })

      vim.keymap.set('n', '<Leader>df', function() widgets.centered_float(widgets.frames) end,
        { desc = 'DAP: frames widget' })

      vim.keymap.set('n', '<Leader>ds', function() widgets.centered_float(widgets.scopes) end,
        { desc = 'DAP: scopes widget' })
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    tag = 'v3.8.4',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dapui').setup({
        controls = {
          element = "repl",
          enabled = true,
          icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
          }
        },
        element_mappings = {},
        expand_lines = false,
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" }
          }
        },
        force_buffers = false,
        icons = {
          collapsed = "",
          current_frame = "",
          expanded = ""
        },
        layouts = { {
          elements = {
            {
              id = "breakpoints",
              size = 0.30
            },
            {
              id = "watches",
              size = 0.30
            },
            {
              id = "stacks",
              size = 0.30
            },
            {
              id = "console",
              size = 0.10
            }
          },
          position = "right",
          size = 40
        }, {
          elements = {
            {
              id = "scopes",
              size = 0.5
            },
            {
              id = "repl",
              size = 0.5
            }
          },
          position = "bottom",
          size = 10
        } },
        mappings = {
          edit = "e",
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          repl = "r",
          toggle = "t"
        },
        render = {
          indent = 1,
          max_value_lines = 100
        }
      })

      vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end, { desc = 'DAP UI: toggle' })
      vim.keymap.set('n', '<Leader>dU', function() require('dapui').open({ reset = true }) end,
        { desc = 'DAP UI: reset window' })
    end
  },
}
