return {
  'MagicDuck/grug-far.nvim',
  cmd = 'GrugFar',
  opts = { headerMaxWidth = 40 },
  keys = {
    {
      "<leader>sr",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
  -- config = function()
  --   local grug = require('grug-far')
  --   grug.setup({
  --     -- options, see Configuration section below
  --     -- there are no required options atm
  --   });
  -- end
}
