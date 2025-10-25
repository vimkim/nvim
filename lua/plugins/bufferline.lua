return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant", -- "slant" | "thick" | "thin"
      always_show_bufferline = false,
      show_buffer_close_icons = true,
      show_close_icon = true,
      color_icons = true,
      indicator = { style = "underline" }, -- "icon" | "underline"
      hover = { enabled = true, delay = 100, reveal = { "close" } },
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      offsets = {
        { filetype = "neo-tree", text = "File Explorer", highlight = "Directory", text_align = "left" },
        { filetype = "snacks_layout_box" },
      },
      right_mouse_command = false, -- stop accidental closes
      middle_mouse_command = false,
      get_element_icon = function(opts)
        return LazyVim.config.icons.ft[opts.filetype]
      end,
      max_name_length = 22,
      max_prefix_length = 12,
      truncate_names = true,
      -- optional numbers or pins:
      numbers = "ordinal",
    },
    highlights = {
      buffer_selected = { bold = true, italic = false },
      diagnostic_selected = { bold = true },
      indicator_selected = { sp = "#89b4fa", underline = true }, -- tweak color if desired
    },
  },
}
