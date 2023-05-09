local ok, bufferline = pcall(require, 'bufferline')
if not ok then
    vim.notify('bufferline is not installed')
    return
end

bufferline.setup {
    options = {
        show_close_icon = false,
        modified_icon = '',
        separator_style = 'thin',
        always_show_bufferline = true,
        custom_filter = function(buf_number, _)
            -- ignore quick fix list
            if vim.bo[buf_number].filetype ~= 'qf' then
                return true
            end
        end
    }
}

vim.keymap.set('n', '<space>as', bufferline.pick_buffer, { desc = 'Buffer: pick buffer' })
vim.keymap.set('n', '<space>ac', bufferline.close_with_pick, { desc = 'Buffer: close picked beffer' })
vim.keymap.set('n', '<space>an', function() bufferline.cycle(1) end, { desc = 'Buffer: next buffer' })
vim.keymap.set('n', '<space>ap', function() bufferline.cycle(-1) end, { desc = 'Buffer: previous beffer' })
vim.keymap.set('n', '<space>ad',
    function()
        vim.cmd('wa')
        local active = vim.api.nvim_get_current_buf()
        local buffers = vim.api.nvim_list_bufs()
        for _, b in ipairs(buffers) do
            if 1 == vim.fn.buflisted(b) then
                if active ~= b then
                    vim.api.nvim_buf_delete(b, { force = true })
                end
            end
        end
        vim.cmd('redrawtabline')
        vim.cmd('redraw')
    end,
    { desc = 'Buffer: close other buffers' })
vim.keymap.set('n', '<space>aq', function() vim.cmd('cclose') end, { desc = 'Buffer: close quick list' })
