local which_key_opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local which_key_tables = {
  m = {
    name = "+misc",
    u = { '<cmd>UndotreeToggle<cr>', 'Undotree' },
    l = { '<cmd>Legendary<cr>', 'Legendary' },
  },
  f = {
    name = "+file",
    f = { '<cmd>Telescope find_files<cr>', 'Find File'},
    e = { '<cmd>Neotree position=right toggle<cr>', 'Browse' },
  },
  w = {
    name = "+window",
    h = { '<C-w>h', 'Go to the left window' },
    j = { '<C-w>j', 'Go to the down window' },
    k = { '<C-w>k', 'Go to the up window' },
    l = { '<C-w>l', 'Go to the right window' },
    ["%"] = { '<cmd>set splitright!<cr><cmd>vsplit<cr><cmd>set splitright!<cr>', 'Split window vertically and focus on new' },
    ["\""] = { '<cmd>set splitbelow!<cr><cmd>split<cr><cmd>set splitbelow!<cr>', 'Split window and focus on new' },
  },
  L = {
    name = "+Legendary",
    ["/"] = { '<cmd>Legendary<cr>', 'Search' },
    k = { '<cmd>Legendary keymaps<cr>', 'Search keymaps' },
  },
  l = {
    name = "+lsp",
    a = { function() vim.lsp.buf.code_action() end, 'Code action' },
    m = { '<cmd>Mason<cr>', 'Mason' },
    j = { vim.diagnostic.goto_next, 'Next diagnostic' },
    k = { vim.diagnostic.goto_prev, 'Next diagnostic' },
    l = { vim.lsp.codelens.run, 'CodeLens action' },
    q = { vim.diagnostic.setloclist, 'QuickFix' },
    r = { vim.lsp.buf.rename, 'Rename' },
  },
}

require("which-key").setup {}
local wk = require("which-key")
wk.register(which_key_tables, which_key_opts)

require('legendary.integrations.which-key').bind_whichkey(
  which_key_tables,
  which_key_opts,
  false
)
