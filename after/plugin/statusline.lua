-- Check lualine is installed
local ok, _ = pcall(require, 'lualine')
if not ok then
  print('Lualine is not installed')
  return
end

-- Free the timer if this file is re-sourced
if _G.my_global_statusline_timer then
  _G.my_global_statusline_timer:stop()
  _G.my_global_statusline_timer:close()
  _G.my_global_statusline_timer = nil
end

-- local message = "    So we beat on, boats against the current, borne back ceaselessly into the past."
-- local len = 50
-- local idx = 1
-- local slice = ""
-- local timer = vim.loop.new_timer()
-- timer:start(0, 500, vim.schedule_wrap(function()
--   idx = (idx % #message) + 1 -- Lua strings index from 1
--   -- vim.opt.statusline = string.format("%d", ct)
--   local front = message:sub(idx)
--   local back = message:sub(1, idx - 1)
--   local rotated = front .. back
--   slice = rotated:sub(1, len)
-- end))
-- _G.my_global_statusline_timer = timer

local quotes = {
  "So we beat on, boats against the current, borne back ceaselessly into the past.",
  [[In my younger and more vulnerable years my father gave me some advice that I've been turning over in my mind ever since. "Whenever you feel like criticizing any one," he told me, "just remember that all the people in this world haven't had the advantages that you've had."]],
}
local delim = string.rep(" ", 10)
-- Combine quotes into one string, which is then rotated and sliced
local message = delim .. table.concat(quotes, delim)
local len = 74 -- length of final slice
local idx = 1 -- rotation index
local slice = ""
local timer = vim.loop.new_timer()
timer:start(0, 200, vim.schedule_wrap(function()
  idx = (idx % #message) + 1 -- Lua strings index from 1
  -- vim.opt.statusline = string.format("%d", ct)
  local front = message:sub(idx) -- construct front of rotation
  local back = message:sub(1, idx - 1) -- construct back of rotation
  local rotated = front .. back
  slice = rotated:sub(1, len)
end))
_G.my_global_statusline_timer = timer

-- Get full filename of buffer
local function pathname()
  return vim.fn.expand([[%:~:.]])
end

-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 20,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  -- inactive_sections = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = {'filename'},
  --   lualine_x = {'location'},
  --   lualine_y = {},
  --   lualine_z = {}
  -- },
  tabline = {
    lualine_a = {'tabs'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { function() return slice end },
    lualine_y = {},
    lualine_z = {}
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', newfile_status = true, path = 1, symbols = {readonly = '[RO]'}}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', newfile_status = true, path = 1, symbols = {readonly = '[RO]'}}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {}
}
