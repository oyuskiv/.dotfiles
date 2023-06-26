return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        lazy = false,
        config = function()
            local telescope = require('telescope')
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

            require('telescope').load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff',
                function()
                    builtin.find_files({ no_ignore = true, follow = true })
                end,
                { desc = "Telescope: find files" })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope: live grep" })
            vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Telescope: grep string" })
            vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find,
                { desc = "Telescope: buffer fuzzy find" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope: select buffer" })
            vim.keymap.set('n', '<leader>fd',
                function()
                    builtin.lsp_document_symbols({ show_line = true })
                end,
                { desc = "Telescope: document symbols" })

            -- Fix folding for opened files from Telescope
            vim.api.nvim_create_autocmd('BufRead', {
                callback = function()
                    vim.api.nvim_create_autocmd('BufWinEnter', {
                        once = true,
                        command = 'normal! zx'
                    })
                end
            })
        end
    },
}
