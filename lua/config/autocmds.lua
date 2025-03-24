-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp", "h", "hpp", "cmake" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Set tab settings specifically for C and C++ files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "hpp", "cc", "hh", "lex", "yacc" },
  callback = function()
    vim.bo.cindent = true
    vim.bo.indentexpr = ""
    vim.bo.cinoptions = "j1,f0,^-2,{2,>4,:4,n-2,(0,t0"
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 8
    vim.bo.expandtab = false
  end,
})

-- ###################################################
-- Begin: Disable Netrw and use FZF for directory navigation
-- ###################################################
-- Thanks: https://www.reddit.com/r/neovim/comments/1avthpm/small_snippet_to_use_fzflua_as_replacement_for/
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local fzf_lua = require("fzf-lua")
local loaded_buffs = {}

-- Open fzf in the directory when opening a directory buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function(args)
    -- If netrw is enabled just keep it, but it should be disabled
    if vim.bo[args.buf].filetype == "netrw" then
      return
    end

    -- Get buffer name and check if it's a directory
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if vim.fn.isdirectory(bufname) == 0 then
      return
    end

    -- Prevent reopening the explorer after it's been closed
    if loaded_buffs[bufname] then
      return
    end
    loaded_buffs[bufname] = true

    -- Do not list directory buffer and wipe it on leave
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = args.buf })
    vim.api.nvim_set_option_value("buflisted", false, { buf = args.buf })

    -- Open fzf in the directory
    vim.schedule(function()
      fzf_lua.files({
        cwd = vim.fn.expand("%:p:h"),
      })
    end)
  end,
})

-- This makes sure that the explorer will open again after opening same buffer again
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if vim.fn.isdirectory(bufname) == 0 then
      return
    end
    loaded_buffs[bufname] = nil
  end,
})

-- Use - for opening explorer in current directory
vim.keymap.set("n", "-", function()
  fzf_lua.files({
    cwd = vim.fn.expand("%:p:h"),
  })
end)
-- ###################################################
-- End: Disable Netrw and use FZF for directory navigation
-- ###################################################
