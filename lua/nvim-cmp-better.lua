local ok_lsp, lsp = pcall(require, 'lsp-zero')
local ok_cmp, cmp = pcall(require, 'cmp')
local ok_luasnip, luasnip = pcall(require, 'luasnip')
if not ok_lsp or not ok_cmp or not ok_luasnip then
  error("This module depends on lsp-zero, cmp, and luasnip", 2)
end

local select_opts = {behavior = cmp.SelectBehavior.Select}
local function check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

local M = {}

local copilot_enabled = true -- Initial value depends on whether `M.get_default_custom_cmp_config_ext()` sources copilot by default
-- Functions prefixed with "just" should "just" work
function M.just_toggle_copilot()
  if not copilot_enabled then
    copilot_enabled = true
    cmp.setup(M.get_merged_cmp_config())
    return -- omg
  end

  copilot_enabled = false
  local cmp_config = M.get_merged_cmp_config()
  table.remove(cmp_config.sources, 1)
  cmp.setup(cmp_config)
end

function M.get_merged_cmp_config()
  return lsp.defaults.cmp_config(M.get_default_custom_cmp_config_ext())
end

function M.get_default_custom_cmp_config_ext()
  return {
    sources = {
      {name = 'copilot'},
      --- These are the default sources for lsp-zero
      { name = 'path' },
      { name = 'nvim_lsp' },
      { name = 'buffer', keyword_length = 2 },
      { name = 'luasnip', keyword_length = 2 },
    },
    view = {
      entries = { name = 'custom', selection_order = 'near_cursor' }
    },
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      -- ['<C-y>'] = cmp.mapping.confirm({select = false}),

      -- navigate items on the list
      ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
      ['<Down>'] = cmp.mapping.select_next_item(select_opts),
      -- ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
      -- ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

      -- scroll up and down in the completion documentation
      ['<C-f>'] = cmp.mapping.scroll_docs(3),
      ['<C-b>'] = cmp.mapping.scroll_docs(-3),
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
      end, { 'i', 's' }),

      -- go to previous placeholder in the snippet
      ['<C-h>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),

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
      end, { 'i', 's' }),

      -- when menu is visible, navigate to previous item on list
      -- else, revert to default behavior
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(select_opts)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
  }
end

return M
