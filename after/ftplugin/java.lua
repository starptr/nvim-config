-- TODO: check this is correct automatically
local mason_pkg_path = (vim.fn.stdpath 'data') .. '/mason/packages'
local jdtls_root = mason_pkg_path .. '/jdtls'
local jdtls_jar = jdtls_root .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
-- TODO: support all platforms
local jdtls_config = jdtls_root .. '/config_mac'

local bundle_jars = {}

local java_debug_adapter_root = require('mason-registry').get_package('java-debug-adapter'):get_install_path()
local java_debug_jar_parent = java_debug_adapter_root .. '/extension/server'
local java_debug_jar_pattern = java_debug_jar_parent .. '/com.microsoft.java.debug.plugin-*.jar'
local java_debug_jar = vim.fn.glob(java_debug_jar_pattern, 1)
vim.list_extend(bundle_jars, { java_debug_jar })

local java_test_root = require('mason-registry').get_package('java-test'):get_install_path()
local java_test_jars_parent = java_test_root .. '/extension/server'
local java_test_jars_pattern = java_test_jars_parent .. '/*.jar'
local java_test_jars = vim.fn.glob(java_test_jars_pattern, 1)
local java_test_jar_list = vim.split(java_test_jars, '\n')
vim.list_extend(bundle_jars, java_test_jar_list)

local utils = require('utils')

local config = {
  cmd = {
    'jdtls',
  },
  root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-11',
            path = utils.get_jdk_path_using_jabba('system@11.0.18-aarch64'),
            -- path = '/Users/yuto/.lang-tools/.jabba/jdk/system@11.0.18-aarch64/Contents/Home',
          },
          {
            name = 'JavaSE-17',
            path = utils.get_jdk_path_using_jabba('system@17.0.6-aarch64'),
          },
        },
        updateBuildConfiguration = "interactive",
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
    },
    signatureHelp = { enabled = true },
    -- extendedClientCapabilities = extendedClientCapabilities,,
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  on_attach = function(client, bufnr)
    require('jdtls.setup').add_commands()
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs({
      config_overrides = {
        stepFilters = {
          skipClasses = { '$JDK', 'jdk.*', 'java.*', 'javax.*', 'sun.*', 'sunw.*', 'com.sun.*' };
        },
      },
    })
  end,
  init_options = {
    bundles = bundle_jars,
  },
}
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup('LoadJdtlsForJava', { clear = true }),
  callback = function ()
    require('jdtls').start_or_attach(config)
  end,
})

-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- local config = {
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = {
-- 
--     -- 💀
--     'java', -- or '/path/to/java17_or_newer/bin/java'
--             -- depends on if `java` is in your $PATH env variable and if it points to the right version.
-- 
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-Xms1g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
-- 
--     -- 💀
--     -- '-jar', '/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar',
--     '-jar', jdtls_jar,
--          -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--          -- Must point to the                                                     Change this to
--          -- eclipse.jdt.ls installation                                           the actual version
-- 
-- 
--     -- 💀
--     -- '-configuration', '/path/to/jdtls_install_location/config_SYSTEM',
--     '-configuration', jdtls_config,
--                     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--                     -- Must point to the                      Change to one of `linux`, `win` or `mac`
--                     -- eclipse.jdt.ls installation            Depending on your system.
-- 
-- 
--     -- 💀
--     -- See `data directory configuration` section in the README
--     '-data', '/path/to/unique/per/project/workspace/folder'
--   },
-- 
--   -- 💀
--   -- This is the default if not provided, you can remove it. Or adjust as needed.
--   -- One dedicated LSP server & client will be started per unique root_dir
--   root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
-- 
--   -- Here you can configure eclipse.jdt.ls specific settings
--   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- for a list of options
--   settings = {
--     java = {
--     }
--   },
-- 
--   -- Language server `initializationOptions`
--   -- You need to extend the `bundles` with paths to jar files
--   -- if you want to use additional eclipse.jdt.ls plugins.
--   --
--   -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--   --
--   -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
--   init_options = {
--     bundles = {}
--   },
-- }
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- require('jdtls').start_or_attach(config)
