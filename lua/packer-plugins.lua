-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'
  -- The above plugins are allowed to be on rolling commits.
  -- NOTE: All other plugins must be pinned to a specific commit or tag.
  -- When upgrading a plugin (i.e. changing the tag or commit hash), take care
  -- to update `use -> config`, files in `after/plugin/*`, and the keymaps in
  -- `after/plugin/which_key.lua` specifically.

  use {
    'windwp/nvim-ts-autotag',
    commit = "fdefe46c6807441460f11f11a167a2baf8e4534b",
  }

  use {
    'windwp/nvim-autopairs',
    commit = '03580d758231956d33c8dd91e2be195106a79fa4',
  }

  use {
    'f-person/git-blame.nvim',
    commit = 'd3afb1c57918720548effb42edec530232436378',
  }
  
  use {
    'nvim-lualine/lualine.nvim',
    commit = '32a7382a75a52e8ad05f4cec7eeb8bbfbe80d461',
  }
  
  use {
    'ruifm/gitlinker.nvim',
    commit = "c68d4873a14d2ae614875685ccca2e49472989e8",
  }
  
  use {
    'nvim-neo-tree/neo-tree.nvim',
    tag = '2.47',
    requires = {
      "nvim-lua/plenary.nvim",
      { "nvim-tree/nvim-web-devicons", commit = "05e1072f63f6c194ac6e867b567e6b437d3d4622" },
      { "MunifTanjim/nui.nvim", commit = "5d1ca66829d8fac9965cd18fcc2cd9aa49ba1ea5" },
    },
  }

  use {
    'folke/which-key.nvim',
    commit = '86a58eac6a3bc69f5aa373b29df993d14fda3307',
  }

  use {
    'mrjones2014/legendary.nvim',
    tag = 'v2.5.2',
  }

  use {
    'gpanders/editorconfig.nvim',
	  tag = 'v1.3.1',
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    commit = "eb581c105321e26b2dc3f8e83f0ebdbbc3701865",
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig', commit = "9d9ed94f92223755e3ed1500bbf5093a2ebb0cdd" },
      {'williamboman/mason.nvim', commit = "e6f6f901959d39d112b096d26b909c65723981d3" },
      {'williamboman/mason-lspconfig.nvim', commit = "5bea0e851b8f48479d2cb927cd26733b4058b2b3" },

      -- Autocompletion
      {'hrsh7th/nvim-cmp', commit = "8bbaeda725d5db6e4e1be2867a64b43bf547cf06" },
      {'hrsh7th/cmp-buffer', commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
      {'hrsh7th/cmp-path', commit = "91ff86cd9c29299a64f968ebb45846c485725f23" },
      {'saadparwaiz1/cmp_luasnip', commit = "18095520391186d634a0045dacaa346291096566" },
      {'hrsh7th/cmp-nvim-lsp', commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" },
      {'hrsh7th/cmp-nvim-lua', commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" },
  
      -- Snippets
      {'L3MON4D3/LuaSnip', commit = "5570fd797eae0790affb54ea669a150cad76db5d" },
      {'rafamadriz/friendly-snippets', commit = "1a6a02350568d6830bcfa167c72f9b6e75e454ae" },
    },
  }
  
  use {
    'mbbill/undotree',
    commit = "1a23ea84bd02c34f50d8e10a8b4bfc89597ffe4e",
  }
  
  use {
    'nvim-treesitter/nvim-treesitter',
    tag = "v0.8.1",
    run = ':TSUpdate',
  }

  use {
    'Mofiqul/vscode.nvim',
    commit = "dabd5454e88d9ac9f91a5c2f9f6b347410e31162",
    setup = function()
      -- Set theme mode
      vim.o.background = 'dark' -- 'dark' or 'light'
    end,
    config = function ()
      -- local c = require('vscode.colors')
      require('vscode').setup({
          -- Enable transparent background
          transparent = true,
      
          -- Enable italic comment
          italic_comments = true,
      
          -- Disable nvim-tree background color
          disable_nvimtree_bg = true,
      
          -- -- Override colors (see ./lua/vscode/colors.lua)
          -- color_overrides = {
          --     vscLineNumber = '#FFFFFF',
          -- },
      
          -- -- Override highlight groups (see ./lua/vscode/theme.lua)
          -- group_overrides = {
          --     -- this supports the same val table as vim.api.nvim_set_hl
          --     -- use colors from this colorscheme by requiring vscode.colors!
          --     Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
          -- }
      })
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'stevearc/dressing.nvim',
    commit = "4436d6f41e2f6b8ada57588acd1a9f8b3d21453c",
    config = function()
    end,
  }
end)
