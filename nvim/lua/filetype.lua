local group_go_indent = vim.api.nvim_create_augroup("golang indent", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" },
    {
        command = "setlocal noexpandtab tabstop=4 shiftwidth=4",
        pattern = "*.go",
        group = group_go_indent,
    })
