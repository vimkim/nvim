return {
  {
    "folke/snacks.nvim",
    opts = {
      -- https://github.com/folke/snacks.nvim/blob/main/docs/bigfile.md
      bigfile = {
        -- your bigfile configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      dashboard = {
        preset = {
          header = [[
    .          .     
  ';;,.        ::'   
,:::;,,        :ccc, 
,::c::,,,,.     :cccc,
,cccc:;;;;;.    cllll,
,cccc;.;;;;;,   cllll;
:cccc; .;;;;;;. coooo;
;llll;   ,:::::'loooo;
;llll:    ':::::loooo:
:oooo:     .::::llodd:
.;ooo:       ;cclooo:.
  .;oc        'coo;.  
    .'         .,.    
    ]],
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            {
              icon = " ",
              key = "F",
              desc = "Find File (CWD)",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.getcwd()})",
            },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.picker.recent({ filter = { cwd = true }})",
            },
            {
              icon = " ",
              key = "R",
              desc = "Recent Files (CWD)",
              action = ":lua Snacks.picker.recent()",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      picker = {
        sources = {
          files = {
            hidden = true, -- show dotfiles
            ignored = false, -- also show .gitignored (set true if you don't want that)
            show_empty = true, -- so the UI opens even if results are initially empty
          },
          -- optional: make live_grep include hidden too
          grep = { hidden = true, ignored = false },
        },
        layout = {
          fullscreen = true,
        },
      },
    },
    keys = {
      {
        "<leader>sf",
        LazyVim.pick("grep_word", { buffers = true }),
        desc = "Visual selection or word (Buffers)",
        mode = { "n", "x" },
      },
    },
  },
}
