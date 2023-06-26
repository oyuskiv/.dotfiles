return {
    --{ 'arcticicestudio/nord-vim' },
    {
        'shaunsingh/nord.nvim',
        lazy = false,
        config = function()
            require('nord').set()
            vim.g.nord_bold = false
            vim.g.nord_italic = false
            vim.g.nord_contrast = true
            vim.g.nord_borders = true
            vim.g.nord_cursorline_transparent = false

            vim.cmd('colorscheme nord')
            -- disable highlight for telescope matching
            vim.cmd('highlight TelescopeMatching gui=NONE guifg=NONE guibg=NONE')
            vim.cmd('highlight qfLineNr gui=NONE')
        end
    },
}
