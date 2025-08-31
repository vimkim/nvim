-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local function map(mode, lhs, rhs, opts)
--   local options = { noremap = true, silent = true }
--   if opts then
--     options = vim.tbl_extend("force", options, opts)
--   end
--   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end

local map = vim.keymap.set

-- create new file with path under cursor
vim.api.nvim_set_keymap("n", "<leader>fn", ":e <C-R><C-F><CR>", { noremap = true, silent = true })

-- colemak keybindings

map("n", "n", "gj", {})
map("n", "N", "J", {})
map("n", "e", "gk", {})
map("n", "E", "K", {})
map("n", "i", "l", {})
map("n", "I", "L", {})

map("n", "l", "i", {})
map("n", "L", "I", {})
map("n", "k", "n", {})
map("n", "K", "N", {})
map("n", "j", "e", {})
map("n", "J", "E", {})

map("n", "gn", "n", {})
map("n", "ge", "e", {})

map("i", ",s", "<ESC>", {})
map("", ",s", "<ESC>:w<CR>", {})
map("", "s,", "<ESC>:w<CR>", {})
map("", ",q", "<ESC>:bd<cr>", {})
map("", "<c-q>", "<ESC>:qa<cr>", {})

-- map("n", ";", ":", {})

-- print current file path
function PrintCurrentDirPath()
  local dir_path = vim.fn.expand("%:p:h") -- Get the full file path
  print(dir_path) -- Print it in the command line
end

vim.api.nvim_create_user_command("PrintDirPath", function()
  PrintCurrentDirPath()
end, {})

vim.api.nvim_set_keymap("n", "<leader>pwd", ":pwd<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>pfd", ":lua PrintCurrentDirPath()<CR>", { noremap = true, silent = true })

-- Function to change cwd to the current buffer's directory
function ChangeCwdToCurrentFile()
  local file_dir = vim.fn.expand("%:p:h") -- Get the directory of the current file
  vim.cmd("cd " .. file_dir) -- Change the working directory to that directory
end

vim.api.nvim_create_user_command("ChangeCwd", function()
  ChangeCwdToCurrentFile()
end, {})

vim.api.nvim_set_keymap("n", "<leader>pf", ":lua ChangeCwdToCurrentFile()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>pr", function()
  vim.cmd("cd " .. vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";"))
  print("Changed to project root: " .. vim.fn.getcwd())
end, { desc = "Change to project root directory" })

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

vim.api.nvim_set_keymap(
  "n",
  "<leader>ch",
  ":Lspsaga outgoing_calls<CR>",
  { desc = "Lspsaga Outgoing Calls", noremap = true, silent = true }
)

-- chezmoi add
vim.api.nvim_set_keymap("n", "<leader>za", ":!chezmoi add %<CR>", { noremap = true, silent = true })

-- Create a custom behavior for gd in Yacc files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yacc", -- FileType for yacc files
  callback = function()
    -- Map gd to search for the word under the cursor prefixed by ^
    vim.keymap.set("n", "gd", function()
      local word = vim.fn.expand("<cword>") -- Get the word under the cursor
      vim.cmd("normal! m'") -- Save current position to the jumplist
      vim.fn.search("^" .. word .. "\\n\\+") -- Search for the word with ^ in front
    end, { buffer = true, desc = "Custom gd for Yacc files" }) -- Set for the buffer only
  end,
})

-- Define a global variable to track "safe mode"
vim.g.safe_mode = false

local function enable_safe_mode()
  vim.g.safe_mode = true
  -- Disable quitting with Ctrl+Q
  vim.keymap.set("n", "<C-q>", "<Nop>", { noremap = true, silent = true, desc = "Disable quit in safe mode" })
  vim.keymap.set("i", "<C-q>", "<Nop>", { noremap = true, silent = true })
end

local function disable_safe_mode()
  vim.g.safe_mode = false
  -- Restore the original quit binding
  vim.keymap.set("n", "<C-q>", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })
  vim.keymap.set("i", "<C-q>", "<Esc>:q<CR>", { noremap = true, silent = true })
end

-- Create commands to toggle
vim.api.nvim_create_user_command("SafeModeOn", enable_safe_mode, {})
vim.api.nvim_create_user_command("SafeModeOff", disable_safe_mode, {})

-- Oil
vim.keymap.set("n", "oi", "<CMD>Oil<CR>", {desc = "Open Oil with file's current directory"})
