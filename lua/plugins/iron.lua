-- lua/plugins/iron.lua
return {
  "Vigemus/iron.nvim",
  -- tell lazy which module has .setup(...)
  main = "iron.core",

  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")
    local common = require("iron.fts.common")

    iron.setup({
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,

        -- Your repl definitions come here
        repl_definition = {
          sh = {
            command = { "zsh" },
          },
          python = {
            command = { "python3" }, -- or { "ipython", "--no-autoindent" }
            format = common.bracketed_paste_python,
            block_dividers = { "# %%", "#%%" },
            env = { PYTHON_BASIC_REPL = "1" }, -- needed for python3.13+
          },

          -- csql (Cubrid) for SQL filetype
          sql = {
            -- adjust args for your environment: db name, user, etc.
            -- e.g. { "csql", "your_db", "-u", "dba" }
            command = { "csql.sh" },
          },
        },

        -- set the file type of the newly created repl to ft
        -- bufnr is the buffer id of the REPL and ft is the filetype of the
        -- language being used for the REPL.
        repl_filetype = function(bufnr, ft)
          -- sql files will use the "sql" repl_definition above
          return ft
        end,

        -- Send selections to the DAP repl if an nvim-dap session is running.
        dap_integration = true,

        -- How the repl window will be displayed
        -- repl_open_cmd = view.bottom(40),
        repl_open_cmd = view.split.vertical("50%"),
      },

      -- Iron's own keymaps (plugin-level)
      keymaps = {
        toggle_repl = "<space>rr",
        restart_repl = "<space>rR",
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_paragraph = "<space>sp",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        send_code_block = "<space>sb",
        send_code_block_and_move = "<space>sn",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
      },

      highlight = {
        italic = true,
      },

      -- ignore blank lines when sending visual select lines
      ignore_blank_lines = true,
    })

    -- normal-mode mappings for Iron commands
    vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
    vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
  end,
}
