local diagnostic_state = true

-- Attach function of lsp servers
local on_attach = function(client, bufnr)
  local navic = require('nvim-navic')
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: go to declaration' }))
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: go to definition' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: show documentation on hover' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: go to implementation' }))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: show signature help' }))
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: add directory to workspace' }))
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: remove directory from workspace' }))
  vim.keymap.set('n', '<leader>wl',
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: list workspace directories' }))
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: go to type definition' }))
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: refactor rename' }))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: code action' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: show references' }))
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: format buffer' }))
  vim.keymap.set('n', '<leader>td',
    function()
      vim.diagnostic.reset()
      if diagnostic_state then
        vim.diagnostic.disable()
        diagnostic_state = false
      else
        vim.diagnostic.enable()
        diagnostic_state = true
      end
    end,
    vim.tbl_deep_extend('error', bufopts, { desc = 'Toogle diagnostic' }))
end

local lsp_flags = {
  debounce_text_changes = 150,
}

return {
  {
    'Saecki/crates.nvim',
    config = function()
      require("crates").setup {
        lsp = {
          enabled = true,
          on_attach = on_attach,
          actions = true,
          completion = true,
          hover = true,
        }
      }
    end
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'SmiteshP/nvim-navic',
      'akinsho/flutter-tools.nvim',
    },
    config = function()
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
          },
          -- If you want to use highlight groups as well (optional):
          highlight = true,
        },
        -- Optional: configure virtual text, float, underline, etc.
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })


      -- Set keymap for diagnostic
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
        vim.tbl_deep_extend('error', opts, { desc = 'Diagnostic: open diagnostic window' }))
      vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end,
        vim.tbl_deep_extend('error', opts, { desc = 'Diagnostic: go to previous message' }))
      vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end,
        vim.tbl_deep_extend('error', opts, { desc = 'Diagnostic: go to next message' }))
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
        vim.tbl_deep_extend('error', opts, { desc = 'Diagnostic: send messages to local list' }))

      -- Set diagnostic config
      vim.diagnostic.config({
        virtual_text = false,
        underline = true,
        severity_sort = true,
        update_in_insert = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      -- Set border for floating preview window
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
        { border = "rounded" })

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Enable golang server
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        single_file_support = false,
      })

      -- Enable golint server
      -- lspconfig.golangci_lint_ls.setup({
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      --   flags = lsp_flags,
      -- })

      -- Enable lua server
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
            workspace = {
              library = {
                -- Make the server aware of Neovim runtime files
                vim.api.nvim_get_runtime_file('', true),
                '${3rd}/luassert/library',
              }
            },
            -- Do not send telemetry data
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Enable bash server
      lspconfig.bashls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Enable python server
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Enable terraform server
      lspconfig.terraformls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Enable groovy server
      lspconfig.groovyls.setup({
        cmd = { 'groovy-language-server' }, -- symlink on "java -jar groovy-language-server-all.jar"
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Enable docker server
      lspconfig.dockerls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Enable yaml server
      lspconfig.yamlls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        settings = {
          yaml = {
            schemas = {
              ['https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.1-standalone-strict/all.json'] =
              '/*k8s*.yaml',
              ['http://json.schemastore.org/kustomization'] = 'kustomization.yaml',
            }
          }
        }
      })

      --Enable flutter/dart server
      require('flutter-tools').setup({
        debugger = {
          enabled = true,
          run_via_dap = true,
          register_configurations = function(_)
            require('dap').configurations.dart = {}
            require('dap.ext.vscode').load_launchjs()
          end,
        },
        lsp = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      })

      -- Enable c++ server
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' } -- 'proto' is excluded
      })

      -- Enable cmake server
      lspconfig.cmake.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Enable rust server
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })
    end
  },
}
