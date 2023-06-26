
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
  	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
  	  -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({
	  'fcpg/vim-fahrenheit', 
	  as = 'fahrenheit',
--	  config=function()
--		  vim.cmd('colorscheme fahrenheit')
--	  end
  })
  use({
        'n1ghtmare/noirblaze-vim',
        as = 'noirblaze',
  })
  use({
      'jesseleite/nvim-noirbuddy',
        as ='noirbuddy'
  })

  use({
        'erizocosmico/vim-firewatch',
        as = 'firewatch',
  })
  use({
        'kooparse/vim-color-desert-night',
        as = 'desert-night'
  })
  use({
        'kjssad/quantum.vim',
        as = 'quantum'
  })
  use({
      'Shadorain/shadotheme',
      as = "shado"
  })
  use({
      'sainnhe/everforest',
      as = 'everforest'
  })
  use({
        'karoliskoncevicius/sacredforest-vim',
        as = 'sacredforest'
  })
  use({
      'UnikMask/iroh-vim',
      as = 'iroh'
  })
  use({
        "TroyFletcher/vim-colors-synthwave",
        as = "synthwave"
  })
  use('szorfein/darkest-space')
  use('liuchengxu/space-vim-theme')

  use('bignimbus/pop-punk.vim')
  use('yassinebridi/vim-purpura')
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    -- {'rafamadriz/friendly-snippets'}, -- Optional
  }
}
use('norcalli/nvim-colorizer.lua')
use('tc50cal/vim-terminal')
use('ryanoasis/vim-devicons')
use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup{
    size = function(term)
      -- print(vim.inspect(term))
      if term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = nil,
    hide_numbers = true,
    start_in_insert = true,
    insert_mappings = true,
    direction = 'horizontal',
  }
end}
use {
  'Luci-4/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
}
use('airblade/vim-gitgutter')
-- use('eandrju/cellular-automaton.nvim')
use('terrortylor/nvim-comment')
use {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup {
        hidden = {"^<", "<", "<*"},
        triggers_blacklist = {
            i = { "<", "i", "k" },
          },

        plugins = {
            presets = {
                nav = nil
            }
        }
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}
use('f-person/git-blame.nvim')
use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
use('Luci-4/cplex-nvim')
use('lervag/vimtex')
end)
