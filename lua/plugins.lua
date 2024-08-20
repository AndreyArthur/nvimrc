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

  -- Statusline and Tabline
  {
    'nvim-lualine/lualine.nvim', -- LuaLine
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
  },

  --Themes
  'folke/tokyonight.nvim',
  { 'catppuccin/nvim', name = 'catppuccin' },
  'EdenEast/nightfox.nvim',
  'marko-cerovac/material.nvim',

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter', -- Treesitter
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  'lukas-reineke/indent-blankline.nvim',
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  -- Git integration
  'tpope/vim-fugitive', -- Fugitive
  'lewis6991/gitsigns.nvim', -- Git Signs

  -- Fuzzy find, Grep...
  {
    'nvim-telescope/telescope.nvim', -- Telescope
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      'nvim-telescope/telescope-file-browser.nvim',
      'andrew-george/telescope-themes',
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Edit terminal
  'chomosuke/term-edit.nvim',

  -- AI integration
  'Exafunction/codeium.vim',

  -- LSP and code related things
  'echasnovski/mini.splitjoin', -- Spread lines
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'hrsh7th/nvim-cmp', commit = 'b356f2c' },
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'dcampos/nvim-snippy',
      'dcampos/cmp-snippy',
    },
  },
})
