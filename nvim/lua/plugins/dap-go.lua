return {
    {
        "leoluz/nvim-dap-go",
        commit = "b4ded7de579b4e2a85c203388233b54bf1028816",
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        config = function()
            require('dap-go').setup()
        end
    },
}
