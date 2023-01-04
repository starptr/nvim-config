local lsp = require('lsp-zero')
lsp.set_preferences {
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = false,
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
lsp.nvim_workspace()

lsp.setup()

local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = {behavior = cmp.SelectBehavior.Select}

local function check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

local cmp_config = lsp.defaults.cmp_config({
  sources = {
    {name = 'copilot'},
    --- These are the default sources for lsp-zero
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'luasnip', keyword_length = 2},
  },
  view = {
    entries = {name = 'custom', selection_order = 'near_cursor' }
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    -- ['<C-y>'] = cmp.mapping.confirm({select = false}),

    -- navigate items on the list
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    -- ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    -- ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    -- scroll up and down in the completion documentation
    ['<C-f>'] = cmp.mapping.scroll_docs(3)  ,
    ['<C-b>'] = cmp.mapping.scroll_docs(-3) ,
    -- ['<C-d>'] = cmp.mapping.scroll_docs(5)  ,
    -- ['<C-u>'] = cmp.mapping.scroll_docs(-5) ,

    -- toggle completion
    --
    ['<C-s>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end),

    -- go to next placeholder in the snippet
    ['<C-l>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    -- go to previous placeholder in the snippet
    ['<C-h>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    -- when menu is visible, navigate to next item
    -- when line is empty, insert a tab character
    -- else, activate completion
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif check_back_space() then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    -- when menu is visible, navigate to previous item on list
    -- else, revert to default behavior
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})
cmp.setup(cmp_config)

-- insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
