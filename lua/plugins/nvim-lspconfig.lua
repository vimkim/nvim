return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
      servers = {
        pylsp = { enabled = false },
        typos_lsp = {
          root_dir = function(bufnr, on_dir)
            if vim.bo[bufnr].filetype ~= "cubrid" then
              on_dir()
            end
          end,
        },
      },
    },
  },
}
