local M = {}

M.lsp_flags = {
  debounce_text_changes = 150,
}

M.on_attach = function(client, bufnr)
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
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover { border = 'rounded' } end,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: show documentation on hover' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: go to implementation' }))
  vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help { border = 'rounded' } end,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: show signature help' }))
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: add directory to workspace' }))
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
    vim.tbl_deep_extend('error', bufopts, { desc = 'LSP: remove directory from workspace' }))
  vim.keymap.set('n', '<leader>wl',
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
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
end

return M
