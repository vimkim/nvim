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

-- Disable LazyVim auto format
vim.g.autoformat = false

-- ###################################################
-- Begin: Disable Netrw and use FZF for directory navigation
-- ###################################################
-- Thanks: https://www.reddit.com/r/neovim/comments/1avthpm/small_snippet_to_use_fzflua_as_replacement_for/
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- removed

-- ###################################################
-- End: Disable Netrw and use FZF for directory navigation
-- ###################################################
