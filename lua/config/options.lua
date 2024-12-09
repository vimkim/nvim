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
