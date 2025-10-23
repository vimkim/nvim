return {
  "xvzc/chezmoi.nvim",
  cmd = { "ChezmoiEdit" },
  keys = {
    {
      "<leader>sz",
      pick_chezmoi,
      desc = "Chezmoi",
    },
  },
  opts = {
    edit = {
      watch = false,
      force = false,
    },
    notification = {
      on_open = true,
      on_apply = true,
      on_watch = false,
    },
    telescope = {
      select = { "<CR>" },
    },
  },
  init = function()
    -- run chezmoi edit on file enter
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      -- Windows Fix
      -- thanks to https://github.com/xvzc/chezmoi.nvim/issues/24
      pattern = {
        (vim.fn.expand("~")):gsub("\\", "/") .. "/.local/share/chezmoi/*",
      },
      callback = function()
        vim.schedule(require("chezmoi.commands.__edit").watch)
      end,
    })
  end,
}
