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
        pyright = { enabled = false },
        ruff = { enabled = false },
        pylsp = {
          -- (optional) ensure pylsp runs from your env that has rope/pylsp-rope
          -- cmd = { "uv", "run", "--with", "python-lsp-server,pylsp-rope,python-lsp-ruff", "pylsp" },
          -- or run the following to enable globally with mason's python-lsp-server
          -- $ ~/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/pip install --upgrade rope pylsp-rope python-lsp-ruff
          settings = {
            pylsp = {
              -- Keep Rope data in memory instead of creating .ropeproject.
              rope = { ropeFolder = vim.NIL },
              plugins = {
                -- Rope-based auto-imports
                rope_autoimport = {
                  enabled = true,
                  -- optional extras:
                  -- code_actions = true,
                },
                -- Optional: use ruff for linting/organizing imports
                ruff = { enabled = true, format = { "I" } }, -- organize/sort imports
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
              },
            },
          },
        },
      },
    },
  },
}
