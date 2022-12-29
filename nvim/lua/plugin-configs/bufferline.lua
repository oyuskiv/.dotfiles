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


vim.keymap.set('n', '<space>as', bufferline.pick_buffer, {})
vim.keymap.set('n', '<space>ac', bufferline.close_with_pick, {})
vim.keymap.set('n', '<space>an', function() bufferline.cycle(1) end, {})
vim.keymap.set('n', '<space>ap', function() bufferline.cycle(-1) end, {})
