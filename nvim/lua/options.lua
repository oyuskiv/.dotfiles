vim.opt.expandtab = true -- expand tab by spaces
vim.opt.tabstop = 4 -- number of spaces in tab
vim.opt.number = true -- show line number
vim.opt.splitbelow = true -- force all horizontal splits to go bellow
vim.opt.splitright = true -- force all vertical splits to go right
vim.opt.relativenumber = true -- show relative line number
vim.opt.wrap = false -- not wrap lines
vim.opt.cursorline = true -- highlight the current line
vim.opt.shiftwidth = 4 -- shift indent
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- take into accout case if search pattern contains upper case character
vim.opt.showmatch = true -- show match brackets
vim.opt.autowrite = true -- auto write buffer
vim.opt.autowriteall = true -- auto write buffer
vim.opt.scrolloff = 10 -- minimal number of lines to keep above and below the cursor
vim.opt.updatetime = 1000 -- timeout to write swap file on disk
vim.opt.mouse = 'a' -- enable mouse support
vim.opt.pumheight = 10 -- popup menu height
vim.opt.signcolumn = 'yes' -- always show sign column
vim.opt.termguicolors = true -- enable gui colors
vim.opt.laststatus = 3 -- enable global status line
vim.cmd('filetype plugin indent on') -- enable filetype plugin and indentation

-- netrw settings
vim.g.netrw_hide = 1
vim.g.netrw_list_hide = '^\\./$'
vim.g.netrw_banner = 0

vim.g.mapleader = ' '

-- auto format file during save
local group_autoformat = vim.api.nvim_create_augroup('auto format', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
        local bufnr = vim.api.nvim_win_get_buf(0)
        local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
        for _, c in ipairs(clients) do
            if c.server_capabilities.documentFormattingProvider then
                vim.lsp.buf.format { async = false }
                return
            end
        end
        vim.api.nvim_command('%s/\\s\\+$//e')
    end,
    pattern = '*',
    group = group_autoformat
})

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
