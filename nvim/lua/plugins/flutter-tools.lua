return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local lsp_utils = require('lsp_utils')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('flutter-tools').setup({
        ui = {
          border = 'rounded',
          notification_style = 'native',
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
          exception_breakpoints = {},
          register_configurations = function(_)
            -- Provide a default so DAP always has something to launch.
            -- If .vscode/launch.json exists, DAP auto-loads it on demand
            -- and those named configs take precedence.
            require('dap').configurations.dart = {
              {
                type = 'dart',
                request = 'launch',
                name = 'Launch Flutter',
                program = '${workspaceFolder}/lib/main.dart',
                cwd = '${workspaceFolder}',
              },
            }
          end,
        },
        flutter_path = nil, -- auto-detect from PATH
        widget_guides = {
          enabled = false,
        },
        closing_tags = {
          highlight = 'Comment',
          prefix = '// ',
          priority = 10,
          enabled = true,
        },
        dev_log = {
          enabled = false,
        },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = '30vnew',
          auto_open = false,
        },
        lsp = {
          on_attach = lsp_utils.on_attach,
          capabilities = capabilities,
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = 'prompt',
            enableSnippets = true,
            updateImportsOnRename = true,
          },
        },
      })

      -- Telescope flutter extension (device/emulator/command picker)
      require('telescope').load_extension('flutter')

      local map = function(key, cmd, desc)
        vim.keymap.set('n', key, cmd, { noremap = true, silent = true, desc = desc })
      end

      -- Run & lifecycle
      map('<leader>Fr', '<cmd>FlutterRun<cr>', 'Flutter: run app (pick device)')
      map('<leader>Fq', '<cmd>FlutterQuit<cr>', 'Flutter: quit app')
      map('<leader>Fh', '<cmd>FlutterReload<cr>', 'Flutter: hot reload')
      map('<leader>FR', '<cmd>FlutterRestart<cr>', 'Flutter: hot restart')

      -- Devices / emulators
      map('<leader>Fd', '<cmd>FlutterDevices<cr>', 'Flutter: list devices')
      map('<leader>Fe', '<cmd>FlutterEmulators<cr>', 'Flutter: list emulators')

      -- Tooling
      map('<leader>Fo', '<cmd>FlutterOutline<cr>', 'Flutter: toggle outline')
      map('<leader>Fv', '<cmd>FlutterVisualDebug<cr>', 'Flutter: toggle visual debug')
      map('<leader>Ft', '<cmd>FlutterDevTools<cr>', 'Flutter: open DevTools')
      map('<leader>Fl', '<cmd>FlutterLspRestart<cr>', 'Flutter: restart LSP')
      map('<leader>FD', '<cmd>FlutterCopyProfilerUrl<cr>', 'Flutter: copy profiler URL')

      -- Telescope command/device picker
      map('<leader>Fs', '<cmd>Telescope flutter commands<cr>', 'Flutter: command picker')
    end,
  },
}
