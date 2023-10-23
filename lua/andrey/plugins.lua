-- Automatically install Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- Filetree
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        version = '2.0.1'
      },
    }
  },

  -- Statusline and Tabline
  {
    'nvim-lualine/lualine.nvim', -- LuaLine
    dependencies = {'nvim-tree/nvim-web-devicons' , lazy = true } -- LuaLine icons
  },

  --Themes
  'folke/tokyonight.nvim', -- TokyoNight theme
  'rebelot/kanagawa.nvim', -- Kanagawa theme
  'ellisonleao/gruvbox.nvim', -- Gruvbox theme
  'navarasu/onedark.nvim', -- One Dark theme

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter', -- Treesitter
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Scrolling animations
  'karb94/neoscroll.nvim', -- Neoscroll

  -- Git integration
  'tpope/vim-fugitive', -- Fugitive
  'lewis6991/gitsigns.nvim', -- Git Signs

  -- Fuzzy find, Grep...
  {
    'nvim-telescope/telescope.nvim', -- Telescope
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'BurntSushi/ripgrep'}
    }
  },

  -- Debugger
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'jay-babu/mason-nvim-dap.nvim',
    }
  },

  -- LSP and code related things
  'echasnovski/mini.splitjoin', -- Spread lines
  'windwp/nvim-autopairs', -- AutoPairs
  'kylechui/nvim-surround', -- Surrounding
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      { 'L3MON4D3/LuaSnip', version = "v2.*", build = "make install_jsregexp" },
    }
  }
})
