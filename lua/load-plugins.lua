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
  {
    'starptr/nvim-jdtls',
    dev = true,
  },
  -- The plugins above are local

  {
    'rcarriga/nvim-dap-ui',
    commit = 'b80227ea56a48177786904f6322abc8b2dc0bc36'
  },

  {
    'mfussenegger/nvim-dap',
    commit = 'c64a6627bb01eb151da96b28091797beaac09536'
  },

  -- {
  --   'mfussenegger/nvim-jdtls',
  --   name = 'nvim-jdtls-upstream',
  --   commit = 'beb9101fb4a8a4f2655e691980b4c82a27d2e920'
  -- },

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
    commit = '32a7382a75a52e8ad05f4cec7eeb8bbfbe80d461',
  },

  {
    'ruifm/gitlinker.nvim',
    commit = "c68d4873a14d2ae614875685ccca2e49472989e8",
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
    commit = "ca02b3b4e5e3fa24f29557e92016c924fd3ad59e",
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig', commit = "bb5675b2daa220a8716eda2c27b23307434f1c31" },
      { 'williamboman/mason.nvim', commit = "9660a811b2e0bd959b63c7f7d41853b49546544d" },
      { 'williamboman/mason-lspconfig.nvim', commit = "5b388c0de30f1605671ebfb9a20a620cda50ffce" },

      -- DAP Support
      -- { "jayp0521/mason-nvim-dap.nvim", commit = "a775db8ac7c468fb05fcf67069961dba0d7feb56" },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp', commit = "8bbaeda725d5db6e4e1be2867a64b43bf547cf06" },
      { 'hrsh7th/cmp-buffer', commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
      { 'hrsh7th/cmp-path', commit = "91ff86cd9c29299a64f968ebb45846c485725f23" },
      { 'saadparwaiz1/cmp_luasnip', commit = "18095520391186d634a0045dacaa346291096566" },
      { 'hrsh7th/cmp-nvim-lsp', commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" },
      { 'hrsh7th/cmp-nvim-lua', commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" },

      -- Snippets
      { 'L3MON4D3/LuaSnip', commit = "5570fd797eae0790affb54ea669a150cad76db5d" },
      { 'rafamadriz/friendly-snippets', commit = "1a6a02350568d6830bcfa167c72f9b6e75e454ae" },
    },
  },

  {
    'mbbill/undotree',
    commit = "1a23ea84bd02c34f50d8e10a8b4bfc89597ffe4e",
  },

  {
    'nvim-treesitter/nvim-treesitter',
    tag = "v0.8.1",
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
