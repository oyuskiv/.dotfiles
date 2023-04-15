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
vim.keymap.set('n', '<space>ad',
    function()
        local active = vim.api.nvim_get_current_buf()
        local buffers = vim.api.nvim_list_bufs()
        for _, b in ipairs(buffers) do
            if active ~= b then
                vim.cmd("wa|bd" .. b)
            end
        end
        vim.cmd("redrawtabline")
        vim.cmd("redraw")
    end,
    { desc = "Buffer: close other buffers" })
vim.keymap.set('n', '<space>aq', function() vim.cmd("cclose") end, { desc = "Buffer: close quick list" })
