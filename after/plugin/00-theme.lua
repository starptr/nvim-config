-- This file must be sourced before other plugin configurations that depend on
-- theme information, such as lualine.

local use_transparent = true

-- Set theme mode
local utils = require('utils')
if utils.is_dark_mode_cached() then
  use_transparent = true
  vim.o.background = 'dark' -- 'dark' or 'light'
  -- require('vscode').change_style('dark')
else
  use_transparent = false
  vim.o.background = 'light'
  -- require('vscode').change_style('light')
end

-- local c = require('vscode.colors')
require('vscode').setup({
    -- Enable transparent background
    transparent = use_transparent,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- -- Override colors (see ./lua/vscode/colors.lua)
    -- color_overrides = {
    --     vscLineNumber = '#FFFFFF',
    -- },

    -- -- Override highlight groups (see ./lua/vscode/theme.lua)
    -- group_overrides = {
    --     -- this supports the same val table as vim.api.nvim_set_hl
    --     -- use colors from this colorscheme by requiring vscode.colors!
    --     Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    -- }
})
