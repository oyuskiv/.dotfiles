return {
    {
        'shaunsingh/nord.nvim',
        lazy = false,
        config = function()
            vim.g.nord_italic = false
            vim.g.nord_contrast = true

            require('nord').set()

            vim.cmd('colorscheme nord')
            -- disable highlight for telescope matching
            vim.cmd('highlight TelescopeMatching gui=NONE guifg=NONE guibg=NONE')
        end
    },
}
