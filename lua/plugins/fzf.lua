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
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-d"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-d"] = { actions.toggle_hidden },
        },
      },
    },
  },
}
