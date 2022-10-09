local ok_cmp, cmp = pcall(require, 'cmp')
if not ok_cmp or cmp == nil then
    vim.notify('nvim-cmp is not installed')
    return
end

local ok_luasnip, luasnip = pcall(require, 'luasnip')
if not ok_luasnip then
    vim.notify('luasnip is not installed')
    return
end

local ok_lspkind, lspkind = pcall(require, 'lspkind')
if not ok_lspkind then
    vim.notify('lspkind is not installed')
    return
end
lspkind.init()

cmp.setup {
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ['c-space>'] = cmp.mapping.complete(),
    },
    sources = {
        { name = 'nvim_lua', max_item_count = 10 },
        { name = 'nvim_lsp', max_item_count = 10 },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', max_item_count = 4, keyword_length = 3 },
        { name = 'nvim_lsp_signature_help' },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[LSP]',
                path = '[path]',
                luasnip = '[snip]',
            }
        }
    },
    window = {
        documentation = {
            max_height = 8,
        },
    },
    view = {
        entries = 'native',
    },
    experimental = {
        ghost_text = true,
    }
}
