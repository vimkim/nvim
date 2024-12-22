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
  },
}
