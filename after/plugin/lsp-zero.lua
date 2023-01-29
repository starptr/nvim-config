-- require('mason-nvim-dap').setup {
--   automatic_setup = true,
-- }

-- local cpptools_debug_adapter_root = require('mason-registry').get_package('cpptools'):get_install_path()
-- local cpptools_debug_adapter_dir = cpptools_debug_adapter_root .. '/extension/debugAdapters'
-- local opendebugad7_exe = cpptools_debug_adapter_dir .. '/bin/OpenDebugAD7'
-- local lldbmi_exe = cpptools_debug_adapter_dir .. '/lldb-mi/bin/lldb-mi'
-- require('dap').adapters.cppdbg = {
--   id = 'cppdbg',
--   type = 'executable',
--   command = lldbmi_exe,
-- }

-- local codelldb_debug_adapter_root = require('mason-registry').get_package('codelldb'):get_install_path()
-- local codelldb_exe = codelldb_debug_adapter_root .. '/codelldb'
-- require('dap').adapters.codelldb = {
--   type = 'server',
--   port = "${port}",
--   executable = {
--     -- CHANGE THIS to your path!
--     command = codelldb_exe,
--     args = {"--port", "${port}"},
-- 
--     -- On windows you may have to uncomment this:
--     -- detached = false,
--   }
-- }
-- 
-- local dap = require('dap')
-- dap.configurations.cpp = {
--   --{
--   --  name = "Specify executable",
--   --  type = "cppdbg",
--   --  request = "launch",
--   --  program = function()
--   --    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--   --  end,
--   --  cwd = '${workspaceFolder}',
--   --  stopAtEntry = true,
--   --  MIMode = "lldb",
--   --  miDebuggerPath = lldbmi_exe,
--   --},
--   {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
--     end,
--     cwd = '${workspaceFolder}/build',
--     stopOnEntry = false,
--   },
--   -- {
--   --   name = 'Attach to gdbserver :1234',
--   --   type = 'cppdbg',
--   --   request = 'launch',
--   --   MIMode = 'gdb',
--   --   miDebuggerServerAddress = 'localhost:1234',
--   --   miDebuggerPath = '/usr/bin/gdb',
--   --   cwd = '${workspaceFolder}',
--   --   program = function()
--   --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--   --   end,
--   -- },
-- }

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

lsp.skip_server_setup({'jdtls'})

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
})
lsp.nvim_workspace {}

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

local ncb = require('nvim-cmp-better')
ncb.setup(ncb.get_default_custom_cmp_config_ext())

-- insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
