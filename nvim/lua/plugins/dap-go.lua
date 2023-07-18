return {
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('dap-go').setup({})

      local dap = require('dap')
      local remote_config = {
        type = "delve",
        name = "Debug (Remote attach)",
        request = "attach",
        mode = "remote",
      }
      table.insert(dap.configurations.go, remote_config)
      dap.adapters.delve = function(callback, _)
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
