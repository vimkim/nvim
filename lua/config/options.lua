-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.wrap = true

opt.exrc = true

-- Function to check if X11 forwarding is enabled
local function is_x11_forwarding_enabled()
  local handle = io.popen("xset q > /dev/null 2>&1 && echo enabled || echo disabled")
  local result = handle:read("*a")
  handle:close()
  return result:match("enabled")
end

-- Configure clipboard based on X11 forwarding
if is_x11_forwarding_enabled() then
  opt.clipboard = "unnamedplus"
else
  opt.clipboard = ""
end

-- Disable banner in netrw
vim.g.netrw_banner = 0
-- Set the listing style
-- vim.g.netrw_liststyle = 3
-- Configure window size
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 0
-- $HOME/temp/tcpdump-with-go/

-- tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 -- Number of spaces for each step of indentation
vim.opt.softtabstop = 4 -- Number of spaces a <Tab> counts for when editing
-- vim.opt.expandtab = true -- (default: true) Use spaces instead of tabs

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- vim.opt_local.iskeyword:remove("_")
    vim.opt_local.iskeyword:remove("-")
  end,
})

vim.opt.langmap =
  "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz"
vim.opt.splitright = true

vim.opt.relativenumber = false
