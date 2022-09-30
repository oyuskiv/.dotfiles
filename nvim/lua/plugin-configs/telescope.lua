local ok, telescope = pcall(require, 'telescope')
if not ok then
    vim.notify('telescope is not installed')
    return
end

telescope.setup {
    defaults = {
        layout_config = { height = 0.90, width = 0.99 },
    },
}
