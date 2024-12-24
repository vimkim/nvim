-- https://www.reddit.com/r/neovim/comments/11wmzlz/telescope_window_width_in_lunarvim/

if true then
  return {}
end

return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        event = "VeryLazy",
        config = function(_, _)
          require("lazyvim.util").on_load("telescope.nvim", function()
            require("telescope").load_extension("live_grep_args")
          end)
        end,
      },
    },
    opts = function(_, opts)
      local lga_actions = require("telescope-live-grep-args.actions")
      opts.extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        },
      }
      opts.defaults = {
        layout_config = {
          width = 0.999, -- Make the overall layout take 90% of the screen width
          height = 0.999, -- Make the overall layout take 90% of the screen height
          vertical = {
            preview_height = 0.7, -- Increase the preview height for vertical strategy
          },
          horizontal = {
            preview_width = 0.6, -- Increase preview width for horizontal strategy
          },
        },
      }
    end,
    keys = {
      {
        "<leader>/",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Grep (root dir) with args",
      },
      {
        "<leader>sg",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Grep (root dir) with args",
      },
    },
    config = function(_, opts)
      local tele = require("telescope")
      tele.setup(opts)
      tele.load_extension("live_grep_args")
    end,
  },
}
