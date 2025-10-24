-- if true then
--   return {}
-- end
return {
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      local fzf = require("fzf-lua")
      local config = fzf.config
      local actions = fzf.actions

      -- Quickfix
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
      config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

      -- Trouble
      if LazyVim.has("trouble.nvim") then
        config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
      end

      -- Toggle root dir / cwd
      config.defaults.actions.files["ctrl-r"] = function(_, ctx)
        local o = vim.deepcopy(ctx.__call_opts)
        o.root = o.root == false
        o.cwd = nil
        o.buf = ctx.__CTX.bufnr
        LazyVim.pick.open(ctx.__INFO.cmd, o)
      end
      config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
      config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

      local img_previewer ---@type string[]?
      for _, v in ipairs({
        { cmd = "ueberzug", args = {} },
        { cmd = "chafa", args = { "{file}", "--format=symbols" } },
        { cmd = "viu", args = { "-b" } },
      }) do
        if vim.fn.executable(v.cmd) == 1 then
          img_previewer = vim.list_extend({ v.cmd }, v.args)
          break
        end
      end

      return {
        "default-title",
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        defaults = {
          -- formatter = "path.filename_first",
          formatter = "path.dirname_first",
        },
        previewers = {
          builtin = {
            extensions = {
              ["png"] = img_previewer,
              ["jpg"] = img_previewer,
              ["jpeg"] = img_previewer,
              ["gif"] = img_previewer,
              ["webp"] = img_previewer,
            },
            ueberzug_scaler = "fit_contain",

            -- My Edit to add treesitter context
            treesitter = {
              enable = true,
              context = { max_lines = 10, trim_scope = "inner" },
            },
          },
          git_diff = {
            -- if required, use `{file}` for argument positioning
            -- e.g. `cmd_modified = "git diff --color HEAD {file} | cut -c -30"`
            cmd_deleted = "git diff --color NVIM_HEAD {file}",
            cmd_modified = "git diff --color NVIM_HEAD {file}",
            cmd_untracked = "git diff --color --no-index /dev/null",
            -- git-delta is automatically detected as pager, set `pager=false`
            -- to disable, can also be set under 'git.status.preview_pager'
          },
        },
        -- Custom LazyVim option to configure vim.ui.select
        ui_select = function(fzf_opts, items)
          return vim.tbl_deep_extend("force", fzf_opts, {
            prompt = " ",
            winopts = {
              title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
              title_pos = "center",
            },
          }, fzf_opts.kind == "codeaction" and {
            winopts = {
              layout = "vertical",
              -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 4) + 0.5) + 16,
              width = 0.5,
              preview = not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
                layout = "vertical",
                vertical = "down:15,border-top",
                hidden = "hidden",
              } or {
                layout = "vertical",
                vertical = "down:15,border-top",
              },
            },
          } or {
            winopts = {
              width = 0.5,
              -- height is number of items, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8, #items + 4) + 0.5),
            },
          })
        end,
        winopts = {
          fullscreen = true,
          -- width = 0.8,
          -- height = 0.8,
          row = 0.5,
          col = 0.5,
          preview = {
            scrollchars = { "┃", "" },
          },
        },
        git = {
          diff = {
            cmd = "git --no-pager diff --name-only {ref}",
            ref = "NVIM_HEAD",
            preview = "git diff {ref} {file}",
            -- git-delta is automatically detected as pager, uncomment to disable
            -- preview_pager = false,
            file_icons = true,
            color_icons = true,
            fzf_opts = { ["--multi"] = true },
          },
          hunks = {
            cmd = "git --no-pager diff --color=always NVIM_HEAD",
            ref = "NVIM_HEAD",
            file_icons = true,
            color_icons = true,
            fzf_opts = {
              ["--multi"] = true,
              ["--delimiter"] = ":",
              ["--nth"] = "3..",
            },
          },
        },
        files = {
          cwd_prompt = false,
          actions = {
            -- ["alt-i"] = { actions.toggle_ignore },
            -- ["alt-h"] = { actions.toggle_hidden },
            ["alt-h"] = false,
            ["alt-d"] = { actions.toggle_hidden },
            ["alt-i"] = { actions.toggle_ignore },
          },
        },
        grep = {
          actions = {
            -- ["alt-i"] = { actions.toggle_ignore },
            -- ["alt-h"] = { actions.toggle_hidden },
            ["alt-h"] = false,
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-d"] = { actions.toggle_hidden },
          },
        },
        lsp = {
          symbols = {
            symbol_hl = function(s)
              return "TroubleIcon" .. s
            end,
            symbol_fmt = function(s)
              return s:lower() .. "\t"
            end,
            child_prefix = false,
          },
          code_actions = {
            previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
          },
        },
      }
    end,

    keys = {
      {
        "<leader>ci",
        "<cmd>FzfLua lsp_incoming_calls<CR>",
        desc = "fzf lua incoming calls",
      },
      {
        "go",
        "<cmd>FzfLua lsp_outgoing_calls<CR>",
        desc = "fzf lua outgoing calls",
      },
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
