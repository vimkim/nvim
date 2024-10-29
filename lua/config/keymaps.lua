-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- colemak keybindings

map("", "n", "gj", {})
map("", "N", "J", {})
map("", "e", "gk", {})
map("", "E", "K", {})
map("", "i", "l", {})
map("x", "i", "l", {})
map("", "I", "L", {})

map("", "l", "i", {})
map("", "L", "I", {})
map("", "k", "n", {})
map("", "K", "N", {})
map("", "j", "e", {})
map("", "J", "E", {})

map("", "gn", "n", {})
map("", "ge", "e", {})

map("i", ",s", "<ESC>", {})
map("", ",s", "<ESC>:w<CR>", {})
map("", "s,", "<ESC>:w<CR>", {})
map("", ",q", "<ESC>:bd<cr>", {})
map("", "<c-q>", "<ESC>:qa<cr>", {})

map("n", ";", ":", {})

map("", "<leader>mo", "<ESC>:set nu! mouse=<CR>", {})

map("", "<space>gb", ":Git blame<CR>", {})
