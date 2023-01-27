-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Setup
vim.g.nvim_tree_disable_default_keybindings = 1
require('nvim-tree').setup({
  view = {
    mappings ={
      list = {
        { key = 's', action = 'split' },
        { key = 'v', action = 'vsplit' },
      }
    }
  }
})

