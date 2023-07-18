return {
  {
    'leoluz/nvim-dap-go',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dap-go').setup({})
      local dap = require('dap')
      -- overwrite go configurations
      dap.configurations.go = {
        {
          type = 'go',
          name = 'Attach',
          mode = 'local',
          request = 'attach',
          processId = require('dap.utils').pick_process,
        },
        {
          type = 'go',
          name = 'Debug',
          request = 'launch',
          program = '${fileDirname}',
        },
        {
          type = 'go',
          name = 'Debug with arguments',
          request = 'launch',
          program = '${fileDirname}',
          args = function()
            local co = coroutine.running()
            if co then
              return coroutine.create(function()
                local args = {}
                vim.ui.input({ prompt = 'Arguments: ' }, function(input)
                  args = vim.split(input or '', ' ')
                end)
                coroutine.resume(co, args)
              end)
            else
              local args = {}
              vim.ui.input({ prompt = 'Arguments: ' }, function(input)
                args = vim.split(input or '', ' ')
              end)
              return args
            end
          end,
        },
        {
          type = 'go',
          name = 'Debug test',
          request = 'launch',
          mode = 'test',
          program = './${relativeFileDirname}',
        },
        {
          type = 'go_remote',
          name = 'Debug remote',
          request = 'attach',
          mode = 'remote',
        }
      }

      dap.adapters.go_remote = function(callback, _)
        local address = vim.fn.input('Connect to delve address: ')
        local separator = string.find(address, ':')
        if separator == nil then
          print('Invalid delve address')
          return
        end
        local host = string.sub(address, 0, separator - 1)
        local port = string.sub(address, separator + 1)
        callback({ type = 'server', host = host, port = port, })
      end
    end
  },
}
