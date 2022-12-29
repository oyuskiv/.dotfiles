local group_tab_indent = vim.api.nvim_create_augroup("tab indent", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" },
    {
        command = "setlocal noexpandtab tabstop=4 shiftwidth=4",
        pattern = { "*.go", "Makefile" },
        group = group_tab_indent,
    })
