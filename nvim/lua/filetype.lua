local group_tab_indent = vim.api.nvim_create_augroup("tab indent", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" },
  {
    command = "setlocal noexpandtab tabstop=4 shiftwidth=4",
    pattern = { "*.go", "Makefile", "*.mk" },
    group = group_tab_indent,
  })
local lua_indent = vim.api.nvim_create_augroup("lua indent", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" },
  {
    command = "setlocal shiftwidth=2",
    pattern = { "*.lua" },
    group = lua_indent,
  })
