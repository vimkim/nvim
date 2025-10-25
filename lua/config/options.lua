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

-- Detect if the OS is Windows
local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

-- TODO: xset q is too slow
-- -- Configure clipboard based on X11 forwarding
-- if is_windows or is_x11_forwarding_enabled() then
--   opt.clipboard = "unnamedplus"
-- else
--   opt.clipboard = ""
-- end

opt.clipboard = "unnamedplus"

-- Disable banner in netrw
vim.g.netrw_banner = 0
-- Set the listing style
-- vim.g.netrw_liststyle = 3
-- Configure window size
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 0
-- $HOME/temp/tcpdump-with-go/

-- tabs
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4 -- Number of spaces for each step of indentation
-- vim.opt.softtabstop = 4 -- Number of spaces a <Tab> counts for when editing
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

vim.opt.colorcolumn = "80,120"

vim.g.root_spec = {
  "lsp",
  {
    ".git",
    "lua",
    "justfile",
    -- c & cpp
    "CMakeLists.txt",
    "Makefile",
    "build.ninja",
    -- rust
    "Cargo.toml",
    -- go
    "go.mod",
    -- python
    "pyproject.toml",
    -- node
    "package.json",
    -- java
    "build.gradle",
    "build.gradle.kts",
  },
  "cwd",
}

-- snacks animate disable
-- refer to: https://github.com/folke/snacks.nvim/blob/main/docs/animate.md
-- 2025-10-25: enabing it helps when reading codes
vim.g.snacks_animate = true

-- pyright does not support features like auto-import.
-- refer to nvim-lspconfig.lua
-- vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_lsp = "pylsp"

vim.opt.spelllang = { 'en', 'cjk' }
