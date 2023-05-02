local which_key_opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local which_key_tables = {
  c = {
    name = "+qf",
    o = { '<cmd>copen<cr>', 'Open quickfix' },
    c = { '<cmd>cclose<cr>', 'Close quickfix' },
    n = { '<cmd>cnext<cr>', 'Next location' },
    p = { '<cmd>cprevious<cr>', 'Previous location' },
  },
  m = {
    name = "+misc",
    u = { '<cmd>UndotreeShow<cr><cmd>UndotreeFocus<cr>', 'Focus Undotree' },
    y = { '<cmd>UndotreeHide<cr>', 'Close Undotree' },
    l = { '<cmd>Legendary<cr>', 'Legendary' },
    t = { '<cmd>TroubleToggle<cr>', 'Trouble' },
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
    name = "+search",
    g = { require('telescope.builtin').live_grep, 'Live grep' },
    f = { '<cmd>Telescope find_files<cr>', 'Search files'},
    a = { function() require('telescope.builtin').find_files({
      find_command = { 'rg', '--files', '--color', 'never', '--hidden', '--glob', '!**/.git/*' },
    }) end , 'Search all files' },
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
    s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Search sym (doc)' },
    S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Search sym (wksp)' },
    i = { '<cmd>Telescope diagnostics bufnr=0<cr>', 'Search diagnostics (doc)' },
    w = { '<cmd>Telescope diagnostics<cr>', 'Search diagnostics (wksp)' },
    I = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Document diagnostics' },
    W = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace diagnostics' },
    v = { '<cmd>Telescope lsp_references<cr>', 'Search references' },
    d = { '<cmd>Telescope lsp_definitions<cr>', 'Search definitions' },
    D = { '<cmd>Telescope lsp_type_definitions<cr>', 'Search types defs' },
    Q = { '<cmd>TroubleToggle quickfix<cr>', 'QuickFix' },
    l = { '<cmd>TroubleToggle loclist<cr>', 'Loclist' },
    m = { '<cmd>Mason<cr>', 'Mason' },
    j = { vim.diagnostic.goto_next, 'Next diagnostic' },
    k = { vim.diagnostic.goto_prev, 'Prev diagnostic' },
    c = { vim.lsp.codelens.run, 'CodeLens action' },
    q = { vim.diagnostic.setloclist, 'QuickFix' },
    r = { vim.lsp.buf.rename, 'Rename' },
    f = { require('utils').format, 'Format' },
  },
  s = {
    name = "+specific",
    j = {
      name = "+java",
      v = { function() require('jdtls').extract_variable() end, 'Extract variable' },
      c = { function() require('jdtls').extract_constant() end, 'Extract constant' },
      a = { function() require('jdtls').test_class() end, 'Test class' },
      t = { function() require('jdtls').test_nearest_method() end, 'Test method' },
      f = { function() require('jdtls').organize_imports() end, 'Organize imports' },
      S = { '<cmd>JdtSetRuntime<cr>', 'Set runtime' },
    },
  },
  d = {
    name = "+debug",
    t = { function() require('dap').toggle_breakpoint() end, 'Toggle breakpoint' },
    b = { function() require('dap').step_back() end, 'Step Back' },
    c = { function() require('dap').continue() end, 'Continue' },
    C = { function() require('dap').run_to_cursor() end, 'Run To Cursor' },
    D = { function() require('dap').disconnect() end, 'Disconnect' },
    g = { function() require('dap').session() end, 'Get Session' },
    i = { function()
      local ok, err = pcall(require('dap').step_into)
      if not ok then
        print(err)
      end
    end, 'Step Into' },
    n = { function() require('dap').step_over() end, 'Step Over' },
    o = { function() require('dap').step_out() end, 'Step Out' },
    p = { function() require('dap').pause() end, 'Pause' },
    r = { function() require('dap').repl.toggle() end, 'Toggle Repl' },
    s = { function() require('dap').continue() end, 'Start' },
    q = { function() require('dap').close() end, 'Quit' },
    e = { function() require('dapui').toggle({reset = true}) end, 'Toggle UI' },
  },
  g = {
    name = "+git",
    s = { '<cmd>Git<cr>', 'Status' },
    w = { '<cmd>Gwrite<cr>', 'Write' },
    c = { '<cmd>Git commit<cr>', 'Commit' },
    d = { '<cmd>Git diff<cr>' , 'Diff' },
    g = { ':Git ', 'Run...' },
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
  l = {
    name = "+lsp",
    f = { require('utils').format, 'Format' }, -- Automatically applies to selection only
  },
  s = {
    name = "+specific",
    j = {
      name = "+java",
      m = { function() require('jdtls').extract_method() end, 'Extract method' },
    },
  },
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

