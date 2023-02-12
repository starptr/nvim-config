require("example")
require('remap-cmd-to-meta')

vim.opt.guifont = "Iosevka Nerd Font:h15"
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.softtabstop = 4
-- vim.opt.expandtab = false

vim.opt.wrap = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80'

-- vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.timeoutlen = 300
vim.opt.swapfile = false

vim.opt.cmdheight = 1

if vim.fn.has('gui_vimr') == 1 then
  require('gui-vimr')
end

require("load-plugins")
