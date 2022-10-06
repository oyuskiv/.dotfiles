local ok, bufferline = pcall(require, 'bufferline')
if not ok then
    vim.notify('bufferline is not installed')
    return
end

bufferline.setup {
    options = {
        show_close_icon = false,
        modified_icon = '',
        separator_style = 'thin'
    }
}
