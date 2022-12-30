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
  ["<leader>"] = {
    name = "+QOL",
    p = { '"+p', 'Paste after cursor from clipboard' },
    P = { '"+P', 'Paste before cursor from clipboard' },
    y = { '"+y', 'Yank to clipboard' },
    Y = { function()
      require('gitlinker').get_buf_range_url('n', {})
    end, 'Yank shareable permalink to clipboard' },
    d = { '"_d', 'Cut without yank' },
    D = { '"_D', 'Cut until EOL without yank' },
    c = { '"_c', 'Change without yank' },
    C = { '"_C', 'Change until EOL without yank' },
    s = { '"_s', 'Delete and insert without yank' },
    S = { '"_S', 'Delete line and insert without yank' },
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

local which_key_opts_visual = {
  mode = 'v',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local which_key_tables_visual = {
  ["<leader>"] = {
    name = "+QOL",
    -- We don't need 4 paste variants because when replacing selected text, before & after cursor are the same
    p = { [["_dP]], 'Paste without yank' },
    P = { [["_d"+P]], 'Paste without yank from clipboard' },
    y = { '"+y', 'Yank to clipboard' },
    Y = { function()
      require('gitlinker').get_buf_range_url('v', {})
    end, 'Yank shareable permalink to clipboard' },
    d = { '"_d', 'Cut without yank' },
    D = { '"_D', 'Cut until EOL without yank' },
    c = { '"_c', 'Change without yank' },
    C = { '"_C', 'Change until EOL without yank' },
    s = { '"_s', 'Delete and insert without yank' },
    S = { '"_S', 'Delete line and insert without yank' },
  },
}

require("which-key").setup {}
local wk = require("which-key")
wk.register(which_key_tables, which_key_opts)
wk.register(which_key_tables_visual, which_key_opts_visual)

require('legendary.integrations.which-key').bind_whichkey(
  which_key_tables,
  which_key_opts,
  false
)

require('legendary.integrations.which-key').bind_whichkey(
  which_key_tables_visual,
  which_key_opts_visual,
  false
)

