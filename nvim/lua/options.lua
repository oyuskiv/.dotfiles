vim.opt.expandtab = true -- expand tab by spaces
vim.opt.tabstop = 4 -- number of spaces in tab
vim.opt.number = true -- show line number
vim.opt.splitbelow = true -- force all horizontal splits to go bellow
vim.opt.splitright = true -- force all vertical splits got go right
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
vim.opt.mouse = "a" -- enable mouse support
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.termguicolors = true -- enable gui colors
vim.opt.laststatus = 3 -- enable global status line
vim.cmd('filetype plugin indent on') -- enable filetype plugin and indentation
vim.cmd([[autocmd BufWritePre * :%s/\s\+$//e]]) -- remove all trailing whitespace
vim.cmd([[
let g:netrw_list_hide = '^\./$'
let g:netrw_hide = 1
]]) -- netrw settings
