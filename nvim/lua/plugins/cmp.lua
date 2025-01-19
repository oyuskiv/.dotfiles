return {
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { 'Snikimonkd/cmp-go-pkgs' },
  {
    'L3MON4D3/LuaSnip',
    version = "v2.*"
  },
  { 'saadparwaiz1/cmp_luasnip' },
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
      'Snikimonkd/cmp-go-pkgs',
      'Saecki/crates.nvim', -- configured in lsp
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      cmp.setup {
        mapping = {
          -- scroll docs
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- close completion menu
          ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
          -- confirm selection
          ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          -- call completion
          ['<C-space>'] = cmp.mapping.complete(),
          -- select next item in menu
          ['<C-n>'] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Down>', true, true, true), 'n', true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end
          }),
          -- select prev item in menu
          ['<C-p>'] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Up>', true, true, true), 'n', true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end
          }),
          -- safely select entry
          -- if nothing is selected (including preselections) add a newline as usual
          -- if something has explicitly been selected by the user, select it
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          }),
        },
        completion = {
          completeopt = vim.o.completeopt,
        },
        sources = {
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'luasnip',                max_item_count = 4, keyword_length = 3 },
          { name = 'buffer',                 max_item_count = 4, keyword_length = 3 },
          { name = 'nvim_lsp_signature_help' },
          { name = 'go_pkgs' }, -- go packages
          { name = "crates" },  -- rust crates
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
              go_pkgs = '[pkgs]',
              luasnip = '[snip]',
            }
          }
        },
        window = {
          documentation = {
            max_height = 8,
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
          },
        },
        view = {
          entries = 'custom',
        },
        experimental = {
          ghost_text = true,
        }
      }
    end
  }
}
