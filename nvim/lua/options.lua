vim.opt.expandtab = true             -- expand tab by spaces
vim.opt.tabstop = 4                  -- number of spaces in tab
vim.opt.number = true                -- show line number
vim.opt.splitbelow = true            -- force all horizontal splits to go below
vim.opt.splitright = true            -- force all vertical splits to go right
vim.opt.relativenumber = true        -- show relative line number
vim.opt.wrap = false                 -- not wrap lines
vim.opt.cursorline = true            -- highlight the current line
vim.opt.shiftwidth = 4               -- shift indent
vim.opt.ignorecase = true            -- ignore case in search patterns
vim.opt.smartcase = true             -- take into accout case if search pattern contains upper case character
vim.opt.showmatch = true             -- show match brackets
vim.opt.autowrite = true             -- auto write buffer
vim.opt.autowriteall = true          -- auto write buffer
vim.opt.scrolloff = 10               -- minimal number of lines to keep above and below the cursor
vim.opt.updatetime = 1000            -- timeout to write swap file on disk
vim.opt.mouse = 'a'                  -- enable mouse support
vim.opt.pumheight = 10               -- popup menu height
vim.opt.signcolumn = 'yes'           -- always show sign column
vim.opt.termguicolors = true         -- enable gui colors
vim.opt.laststatus = 3               -- enable global status line
vim.cmd('filetype plugin indent on') -- enable filetype plugin and indentation

-- netrw settings
vim.g.netrw_hide = 1
vim.g.netrw_list_hide = '^\\./$'
vim.g.netrw_banner = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

-- indent text
vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true, silent = true, desc = "normal mode: shift text to right" })
vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true, silent = true, desc = "normal mode: shift text to left" })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true, desc = "visual mode: shift text to right" })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true, desc = "visual mode: shift text to left" })

-- move text up/down
vim.api.nvim_set_keymap('x', '<C-k>', ":move '<-2<CR>gv-gv",
  { noremap = true, silent = true, desc = "visual mode: move block up" })
vim.api.nvim_set_keymap('x', '<C-j>', ":move '>+1<CR>gv-gv",
  { noremap = true, silent = true, desc = "visual mode: move block down" })

-- window navigation
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k',
  { noremap = true, silent = true, desc = "select above window" })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j',
  { noremap = true, silent = true, desc = "select below window" })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h',
  { noremap = true, silent = true, desc = "select left window" })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l',
  { noremap = true, silent = true, desc = "select right window" })

-- clear highlight
vim.api.nvim_set_keymap('n', '<leader>l', ':noh<CR>',
  { noremap = true, silent = true, desc = "clear highlight" })

-- resize window
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>',
  { noremap = true, silent = true, desc = "normal mode: window resize -2" })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>',
  { noremap = true, silent = true, desc = "normal mode: window resize +2" })
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>',
  { noremap = true, silent = true, desc = "normal mode: window vertical resize -2" })
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>',
  { noremap = true, silent = true, desc = "normal mode: window vertical resize +2" })

-- don't overwrite buffer after paste
vim.api.nvim_set_keymap('v', 'p', '"_dP', { noremap = true, silent = true })
