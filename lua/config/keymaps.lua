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

-- create new file with path under cursor
vim.api.nvim_set_keymap("n", "<leader>gf", ":e <C-R><C-F><CR>", { noremap = true, silent = true })

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

-- print current file path
function PrintCurrentFilePath()
  local file_path = vim.fn.expand("%:p") -- Get the full file path
  print(file_path) -- Print it in the command line
end

vim.api.nvim_create_user_command("PrintFilePath", function()
  PrintCurrentFilePath()
end, {})

vim.api.nvim_set_keymap("n", "<leader>pf", ":lua PrintCurrentFilePath()<CR>", { noremap = true, silent = true })

-- Function to change cwd to the current buffer's directory
function ChangeCwdToCurrentFile()
  local file_dir = vim.fn.expand("%:p:h") -- Get the directory of the current file
  vim.cmd("cd " .. file_dir) -- Change the working directory to that directory
end

vim.api.nvim_create_user_command("ChangeCwd", function()
  ChangeCwdToCurrentFile()
end, {})

vim.api.nvim_set_keymap("n", "<leader>cd", ":lua ChangeCwdToCurrentFile()<CR>", { noremap = true, silent = true })

-- for gdb breakpoints
vim.api.nvim_set_keymap(
  "n",
  "<leader>dx",
  ':let @+="b " . expand("%") . ":" . line(".")<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>!", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>@", ":BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>#", ":BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>$", ":BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>%", ":BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>^", ":BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>&", ":BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>*", ":BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>(", ":BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
