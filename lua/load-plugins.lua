local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  dev = {
    path = "~/src-nvim-plugin-dev",
  }
}

return require('lazy').setup({
  'nvim-lua/plenary.nvim',
  -- The above plugins are allowed to be on rolling commits.
  -- NOTE: All other plugins must be pinned to a specific commit or tag.
  -- When upgrading a plugin (i.e. changing the tag or commit hash), take care
  -- to update `use -> config`, files in `after/plugin/*`, and the keymaps in
  -- `after/plugin/which_key.lua` specifically.

  -- The plugins below are local
  -- lazy.nvim does not manage local plugins; you must clone these yourself
  --{
  --  'starptr/nvim-jdtls',
  --  dev = true,
  --},
  -- The plugins above are local

  {
    'tzachar/local-highlight.nvim',
    config = function()
      require('local-highlight').setup({})
    end
  },

  {
    'tpope/vim-fugitive'
  },
  {
    'rbong/vim-flog'
  },
  {
    'folke/trouble.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons", commit = "05e1072f63f6c194ac6e867b567e6b437d3d4622" },
  },
  {
    'rcarriga/nvim-dap-ui',
    commit = 'b80227ea56a48177786904f6322abc8b2dc0bc36'
  },

  {
    'mfussenegger/nvim-dap',
    commit = 'c64a6627bb01eb151da96b28091797beaac09536'
  },

  {
    'mfussenegger/nvim-jdtls',
    name = 'nvim-jdtls-upstream',
    commit = 'beb9101fb4a8a4f2655e691980b4c82a27d2e920'
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    commit = '915558963709ea17c5aa246ca1c9786bfee6ddb4'
  },

  {
    'zbirenbaum/copilot.lua',
    commit = '81eb5d1bc2eddad5ff0b4e3c1c4be5c09bdfaa63',
    event = 'VimEnter',
    config = function()
      vim.defer_fn(function()
        require('copilot').setup()
      end, 100)
    end,
  },

  {
    'zbirenbaum/copilot-cmp',
    commit = '84d5a0e8e4d1638e7554899cb7b642fa24cf463f',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end
  },

  {
    'windwp/nvim-ts-autotag',
    commit = "fdefe46c6807441460f11f11a167a2baf8e4534b",
  },

  {
    'windwp/nvim-autopairs',
    commit = '03580d758231956d33c8dd91e2be195106a79fa4',
  },

  {
    'f-person/git-blame.nvim',
    commit = 'd3afb1c57918720548effb42edec530232436378',
  },

  {
    'nvim-lualine/lualine.nvim',
  },

  {
    'ruifm/gitlinker.nvim',
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    tag = '2.47',
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-tree/nvim-web-devicons", commit = "05e1072f63f6c194ac6e867b567e6b437d3d4622" },
      { "MunifTanjim/nui.nvim", commit = "5d1ca66829d8fac9965cd18fcc2cd9aa49ba1ea5" },
    },
  },

  {
    'folke/which-key.nvim',
    commit = '86a58eac6a3bc69f5aa373b29df993d14fda3307',
  },

  {
    'mrjones2014/legendary.nvim',
    tag = 'v2.5.2',
  },

  {
    'gpanders/editorconfig.nvim',
    tag = 'v1.3.1',
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- DAP Support
      -- { "jayp0521/mason-nvim-dap.nvim", commit = "a775db8ac7c468fb05fcf67069961dba0d7feb56" },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
  },

  {
    'mbbill/undotree',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    tag = "v0.9.0",
    build = ':TSUpdate',
  },

  {
    'Mofiqul/vscode.nvim',
    commit = "dabd5454e88d9ac9f91a5c2f9f6b347410e31162",
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  {
    'stevearc/dressing.nvim',
    commit = "4436d6f41e2f6b8ada57588acd1a9f8b3d21453c",
  },
}, opts)
