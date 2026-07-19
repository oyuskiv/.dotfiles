return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        'bash',
        'toml',
        'json',
        'yaml',
        'python',
        'lua',
        'c',
        'cpp',
        'cmake',
        'make',
        'dockerfile',
        'go',
        'gomod',
        'vim',
        'rust',
        'markdown',
        'java',
        'javascript',
        'dart',
        'hcl',
        'http',
      })

      -- Fold defaults (foldexpr/foldmethod are set per-buffer in the autocmd below,
      -- only when a parser is actually active). Open files unfolded.
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99

      -- Enable highlight + indent + folding whenever a buffer's filetype has a parser.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user_treesitter', { clear = true }),
        callback = function(args)
          local buf = args.buf

          -- Big-file guard (was `highlight.disable`). Note: original used 1244 by
          -- typo; this is a true 5 MB limit.
          local max_filesize = 5 * 1024 * 1024 -- 5 MB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return
          end

          -- Highlight. pcall makes this a no-op for filetypes without a parser.
          if not pcall(vim.treesitter.start) then
            return
          end

          -- Folding (native) + indentation (plugin, experimental) — only when a
          -- parser is active for this buffer.
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
