local builtin = require('telescope.builtin')

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = require('telescope.actions').move_selection_next,
        ["<c-k>"] = require('telescope.actions').move_selection_previous,
      },
    }
  }
})

vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
