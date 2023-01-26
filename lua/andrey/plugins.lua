local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	})
	print('Installing packer close and reopen Neovim...')
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'rounded' })
		end,
	},
})

-- Installed Plugins
return packer.startup(function(use)
  -- Plugin Manager
  use 'wbthomason/packer.nvim'  -- Packer itself

  -- Filetree
  use {
    'nvim-tree/nvim-tree.lua', -- Nvim tree
    requires = 'nvim-tree/nvim-web-devicons' -- Nvim tree icons
  }
  -- To make neovim fancy
  use {
    'nvim-lualine/lualine.nvim', -- LuaLine
    requires = { 'kyazdani42/nvim-web-devicons', opt = true } -- LuaLine icons
  }
  use 'folke/tokyonight.nvim' -- TokyoNight theme
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}) -- Treesitter

  -- Git Utilities
  use 'tpope/vim-fugitive' -- Fugitive
	use 'lewis6991/gitsigns.nvim' -- Git Signs

  -- Telescope (Live Grep, Find Files, Buffers, Help)
  use {
    'nvim-telescope/telescope.nvim', -- Telescope
    requires = {
      {'nvim-lua/plenary.nvim'} ,
      {'BurntSushi/ripgrep'}
    }
  }

  -- Code Related
  use 'windwp/nvim-autopairs' -- AutoPairs
  use {
    'VonHeikemen/lsp-zero.nvim', -- Lsp
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
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)
