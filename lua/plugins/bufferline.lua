return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant", -- "slant" | "thick" | "thin"
      show_buffer_close_icons = false,
      show_close_icon = false,
      -- color_icons = true,
      indicator = { style = "icon" }, -- "icon" | "underline"
      hover = { enabled = true, delay = 100, reveal = { "close" } },
      -- diagnostics = "nvim_lsp",
      diagnostics = false,
      -- diagnostics_update_in_insert = false,
      right_mouse_command = false, -- stop accidental closes
      middle_mouse_command = false,
      get_element_icon = function(opts)
        return LazyVim.config.icons.ft[opts.filetype]
      end,
      padding = 0,
      max_name_length = 15,
      max_prefix_length = 6,
      truncate_names = true,
      -- optional numbers or pins:
      numbers = "ordinal",
    },
    highlights = {
      buffer_selected = { bold = true, italic = false },
      -- diagnostic_selected = { bold = true },
      indicator_selected = { sp = "#89b4fa", underline = true }, -- tweak color if desired
    },
  },
}
