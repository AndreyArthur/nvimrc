local telescope_builtin = require('telescope.builtin')

pcall(require('telescope').load_extension, 'fzf')

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<c-j>'] = require('telescope.actions').move_selection_next,
        ['<c-k>'] = require('telescope.actions').move_selection_previous,
      },
    },
  },
})

local find_files = function()
  telescope_builtin.find_files({
    find_command = {
      'rg',
      '--files',
      '--iglob',
      '!.git',
      '--iglob',
      '!node_modules',
      '--iglob',
      '!dist',
      '--iglob',
      '!target',
      '--hidden',
      '--no-ignore',
    },
  })
end

local live_grep = function()
  telescope_builtin.live_grep({
    additional_args = {
      '--iglob',
      '!.git',
      '--iglob',
      '!node_modules',
      '--iglob',
      '!node_modules',
      '--iglob',
      '!dist',
      '--iglob',
      '!target',
      '--hidden',
      '--no-ignore',
    },
  })
end

vim.keymap.set('n', '<leader>ff', find_files, {})
vim.keymap.set('n', '<leader>fg', live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
