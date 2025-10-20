return {
  {
    -- Iron.nvim
    -- TIP: in order to escape Terminal-Mode in Iron REPLs, use <C-\><C-n>
    "Vigemus/iron.nvim",
    -- Load on demand; tweak to taste
    cmd = { "IronRepl", "IronFocus", "IronHide", "IronRestart" },
    ft = { "sql", "python", "sh", "zsh" }, -- optional: open REPLs when editing these
    opts = function()
      local view = require("iron.view")
      local common = require("iron.fts.common")

      return {
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = {
              command = { "zsh" },
            },
            python = {
              command = { "python3" }, -- or { "ipython", "--no-autoindent" }
              format = common.bracketed_paste_python,
              block_dividers = { "# %%", "#%%" },
              env = { PYTHON_BASIC_REPL = "1" }, -- needed for python 3.13+
            },
            sql = {
              command = { "csql", "-Sudba", "testdb" },
            }
          },
          -- bufnr = repl buffer id; ft = filetype of source buffer
          repl_filetype = function(bufnr, ft)
            return ft
          end,
          dap_integration = true,
          -- repl_open_cmd = view.bottom(40),
          repl_open_cmd = view.split.vertical.rightbelow("%40"),
          -- If you later want multiple layouts, use a table:
          -- repl_open_cmd = {
          --   view.split.vertical.rightbelow("%40"),
          --   view.split.rightbelow("%25"),
          -- },
        },

        -- Iron's internal keymaps (not Neovim keymaps)
        keymaps = {
          toggle_repl = "<space>rr",
          -- toggle_repl_with_cmd_1 = "<space>rv",
          -- toggle_repl_with_cmd_2 = "<space>rh",
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

        highlight = { italic = true },
        ignore_blank_lines = true,
      }
    end,

    config = function(_, opts)
      local iron = require("iron.core")
      iron.setup(opts)

      -- Your extra Neovim keymaps for Iron commands
      vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>", { desc = "Iron: Focus REPL" })
      vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>",  { desc = "Iron: Hide REPL" })
    end,
  },
}

