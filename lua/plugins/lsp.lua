return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<space>K", vim.lsp.buf.hover, desc = "LSP Hover" }
      opts.inlay_hints = { enabled = false }
      return opts
    end,
  },
}
