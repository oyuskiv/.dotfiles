local ok, telescope = pcall(require, 'telescope')
if not ok then
    vim.notify('telescope is not installed')
    return
end

telescope.setup {
    defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
            prompt_position = "top",
            height = 0.90,
            width = 0.95
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        }
    }
}

telescope.load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>ff',
    function()
        builtin.find_files({ no_ignore = true, follow = true })
    end,
    {})
vim.keymap.set('n', '<space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<space>fs', builtin.grep_string, {})
vim.keymap.set('n', '<space>fc', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<space>fb', builtin.buffers, {})
vim.keymap.set('n', '<space>fd', builtin.lsp_document_symbols, {})
