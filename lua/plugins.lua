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
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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

  -- Git
  'tpope/vim-fugitive', -- Fugitive
  { 'lewis6991/gitsigns.nvim', tag = 'v1.0.2' }, -- Git Signs

  -- Pickers
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

  -- Terminal
  'chomosuke/term-edit.nvim',

  -- LSP and code related things
  'echasnovski/mini.splitjoin', -- Spread lines
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
    },
  },
  'neovim/nvim-lspconfig',
  'mfussenegger/nvim-jdtls',

  -- Completion
  {
    'saghen/blink.cmp',
    build = 'cargo build --release',
  },
})
