return {
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  {
    'L3MON4D3/LuaSnip',
    version = "v2.*"
  },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'rafamadriz/friendly-snippets' },
  {
    'onsails/lspkind.nvim',
    lazy = false,
    config = function()
      require('lspkind').init({
        preset = 'codicons',
      })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- load snipet from  rafamadriz/friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      local luasnip = require('luasnip')

      local opts = { noremap = true, silent = true }

      vim.keymap.set({ 'i', 's' }, '<C-l>',
        function()
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          end
        end,
        vim.tbl_deep_extend('error', opts, { desc = 'Luasnip: expand or jump forward' }))

      vim.keymap.set({ 'i', 's' }, '<C-k>',
        function()
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          end
        end,
        vim.tbl_deep_extend('error', opts, { desc = 'Luasnip: jump backward' }))

      -- vim.keymap.set({ 'i', 's' }, '<C-J>',
      --   function()
      --     if luasnip.choice_active() then
      --       luasnip.change_choice(1)
      --     end
      --   end,
      --   vim.tbl_deep_extend('error', opts, { desc = 'Luasnip: change choise' }))

      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup {
        mapping = {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          ['<C-space>'] = cmp.mapping.complete(),
        },
        sources = {
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          {
            name = 'buffer',
            max_item_count = 4,
            keyword_length = 3,
          },
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
              nvim_lsp = '[lsp]',
              buffer = '[buf]',
              luasnip = '[snip]',
              path = '[path]',
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
    end
  }
}
