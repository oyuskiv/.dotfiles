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

vim.keymap.set('n', '<space>as', bufferline.pick_buffer, { desc = "Buffer: pick buffer" })
vim.keymap.set('n', '<space>ac', bufferline.close_with_pick, { desc = "Buffer: close picked beffer" })
vim.keymap.set('n', '<space>an', function() bufferline.cycle(1) end, { desc = "Buffer: next buffer" })
vim.keymap.set('n', '<space>ap', function() bufferline.cycle(-1) end, { desc = "Buffer: previous beffer" })
vim.keymap.set('n', '<space>ad', function() vim.cmd("wa|%bd|e#|bd#") end, { desc = "Buffer: close other buffers" })
vim.keymap.set('n', '<space>aq', function() vim.cmd("cclose") end, { desc = "Buffer: close quick list" })
