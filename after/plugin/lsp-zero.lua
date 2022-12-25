local lsp = require('lsp-zero')
lsp.set_preferences {
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
  }
}

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
})
-- lsp.nvim_workspace()

lsp.nvim_workspace({
  library = vim.api.nvim_get_runtime_file('', true)
})

local cmp = require('cmp')
lsp.setup_nvim_cmp {
  sources = {
    --- These are the default sources for lsp-zero
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'luasnip', keyword_length = 2},
  },
  -- mapping = {
  --   ['<CR>'] = cmp.mapping.confirm({select = false}),
  --   -- ['<C-y>'] = cmp.mapping.confirm({select = false}),

  --   -- navigate items on the list
  --   ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
  --   ['<Down>'] = cmp.mapping.select_next_item(select_opts),
  --   ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
  --   ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

  --   -- scroll up and down in the completion documentation
  --   ['<C-f>'] = cmp.mapping.scroll_docs(10),
  --   ['<C-b>'] = cmp.mapping.scroll_docs(-10),
  --   ['<C-d>'] = cmp.mapping.scroll_docs(-5),
  --   ['<C-u>'] = cmp.mapping.scroll_docs(-5),

  --   -- toggle completion
  --   ['<C-e>'] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.close()
  --     else
  --       cmp.complete()
  --     end
  --   end),

  --   -- go to next placeholder in the snippet
  --   ['<C-d>'] = cmp.mapping(function(fallback)
  --     if luasnip.jumpable(1) then
  --       luasnip.jump(1)
  --     else
  --       fallback()
  --     end
  --   end, {'i', 's'}),

  --   -- go to previous placeholder in the snippet
  --   ['<C-b>'] = cmp.mapping(function(fallback)
  --     if luasnip.jumpable(-1) then
  --       luasnip.jump(-1)
  --     else
  --       fallback()
  --     end
  --   end, {'i', 's'}),

  --   -- when menu is visible, navigate to next item
  --   -- when line is empty, insert a tab character
  --   -- else, activate completion
  --   ['<Tab>'] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_next_item(select_opts)
  --     elseif s.check_back_space() then
  --       fallback()
  --     else
  --       cmp.complete()
  --     end
  --   end, {'i', 's'}),

  --   -- when menu is visible, navigate to previous item on list
  --   -- else, revert to default behavior
  --   ['<S-Tab>'] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_prev_item(select_opts)
  --     else
  --       fallback()
  --     end
  --   end, {'i', 's'}),
  -- },
}
lsp.setup()

cmp.setup {
  view = {
    entries = {name = 'custom', selection_order = 'near_cursor' }
  },
}
