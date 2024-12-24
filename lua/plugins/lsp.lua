return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      opts.inlay_hints = { enabled = false }
      return opts
    end,
  },
}
