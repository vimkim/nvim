return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      -- colorscheme = "catppuccin-frappe",
      -- colorscheme = "catppuccin-macchiato",
      colorscheme = "catppuccin-mocha",
      -- colorscheme = "rose-pine-moon",
      -- colorscheme = "kanagawa-wave",
    },
  },
  { "EdenEast/nightfox.nvim" },
  {
    "projekt0n/github-nvim-theme",
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
  },
  { "rebelot/kanagawa.nvim" },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  -- quick fix for get error caused by bufferline.nvim
  -- https://github.com/LazyVim/LazyVim/pull/6354#issuecomment-3202799735
  -- {
  --   "akinsho/bufferline.nvim",
  --   init = function()
  --     local bufline = require("catppuccin.groups.integrations.bufferline")
  --     function bufline.get()
  --       return bufline.get_theme()
  --     end
  --   end,
  -- },
}
