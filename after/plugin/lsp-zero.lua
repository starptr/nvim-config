local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
})
lsp.nvim_workspace({
  library = vim.api.nvim_get_runtime_file('', true)
})
lsp.setup()
