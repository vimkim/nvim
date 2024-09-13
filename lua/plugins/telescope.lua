-- https://www.reddit.com/r/neovim/comments/11wmzlz/telescope_window_width_in_lunarvim/
return {
  {
    "telescope.nvim",
    opts = {
      defaults = {
        layout_config = {
          height = 0.95,
          width = 0.98,
        },
      },
    },
  },
}
