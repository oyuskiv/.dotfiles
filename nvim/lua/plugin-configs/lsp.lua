local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    vim.notify('lspconfig is not installed')
    return
end
lspconfig.gopls.setup({}) -- enable golang client
