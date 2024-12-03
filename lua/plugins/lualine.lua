if true then
  return {}
end

local icons = LazyVim.config.icons
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {

      options = {
        theme = "auto",
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        section_separators = "",
        component_separators = "",
      },
      -- sections = {
      --   lualine_c = {
      --     LazyVim.lualine.root_dir(),
      --     {
      --       "diagnostics",
      --       symbols = {
      --         error = icons.diagnostics.Error,
      --         warn = icons.diagnostics.Warn,
      --         info = icons.diagnostics.Info,
      --         hint = icons.diagnostics.Hint,
      --       },
      --     },
      --     { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      --     -- { LazyVim.lualine.pretty_path({ length = 8 }) },
      --     { LazyVim.lualine.pretty_path() },
      --   },
      -- },
    },
  },
}
