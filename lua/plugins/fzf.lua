local actions = require("fzf-lua.actions")
return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        fullscreen = true,
      },
      files = {
        cwd_prompt = false,
        actions = {
          ["alt-h"] = false,
          ["alt-d"] = { actions.toggle_hidden },
          ["alt-i"] = { actions.toggle_ignore },
        },
      },
      grep = {
        actions = {
          ["alt-h"] = false,
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-d"] = { actions.toggle_hidden },
        },
      },
    },
    keys = {
      {
        "<leader>sf",
        function()
          -- Use grep_curbuf with the word under the cursor
          require("fzf-lua").grep_curbuf({ search = vim.fn.expand("<cword>") })
        end,
        desc = "Search current buffer for word under cursor",
      },
      {
        "<leader>sh",
        function()
          require("fzf-lua").search_history()
        end,
        desc = "Search search history",
      },
    },
  },
}
