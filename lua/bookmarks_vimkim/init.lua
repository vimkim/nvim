local M = {}

-- Path to the file that stores the list of saved positions
local positions_file = ".positions"

-- Get the project root (assumes git repo or the current directory)
local function get_project_root()
  local git_dir = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_dir and git_dir ~= "" then
    return git_dir
  else
    return vim.fn.getcwd()
  end
end

-- Save the current file name and line number
function M.save_position()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    print("No file to save.")
    return
  end

  local line = vim.fn.line(".")
  local project_root = get_project_root()
  local path = project_root .. "/" .. positions_file

  -- Append to the positions file
  local f = io.open(path, "a")
  if f then
    f:write(string.format("%s:%d\n", file, line))
    f:close()
    print(string.format("Saved position: %s:%d", file, line))
  else
    print("Failed to open positions file.")
  end
end

function M.open_position()
  local project_root = get_project_root()
  local path = project_root .. "/" .. positions_file

  -- Read saved positions
  local f = io.open(path, "r")
  if not f then
    print("No positions saved.")
    return
  end

  local positions = {}
  for line in f:lines() do
    table.insert(positions, line)
  end
  f:close()

  local has_bat = vim.fn.executable("bat") == 1
  local preview_cmd
  if has_bat then
    preview_cmd = function(entry)
      local entry_str = type(entry) == "table" and entry[1] or entry
      local file, line = string.match(entry_str, "(.+):(%d+)")
      if file and line then
        return string.format("bat --style=numbers --color=always --highlight-line=%s %s", line, file)
      else
        return ""
      end
    end
  else
    preview_cmd = function(entry)
      local entry_str = type(entry) == "table" and entry[1] or entry
      local file, line = string.match(entry_str, "(.+):(%d+)")
      if file and line then
        return string.format("sed -n '%s,%sp' %s", line, line + 10, file)
      else
        return ""
      end
    end
  end

  require("fzf-lua").fzf_exec(positions, {
    prompt = "Select Position> ",
    preview = preview_cmd,
    previewer = "builtin", -- ensure the builtin previewer is used
    actions = {
      ["default"] = function(selected)
        local entry_str = type(selected[1]) == "table" and selected[1][1] or selected[1]
        local file, line = string.match(entry_str, "(.+):(%d+)")
        if file and line then
          vim.cmd(string.format("edit +%s %s", line, file))
        end
      end,
    },
  })
end

-- Key mappings
vim.api.nvim_set_keymap(
  "n",
  "<leader>sp",
  ":lua require'bookmarks_vimkim'.save_position()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>op",
  ":lua require'bookmarks_vimkim'.open_position()<CR>",
  { noremap = true, silent = true }
)

return M
