local scheme = 'nord'
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. scheme)
if not ok then
    return
end
