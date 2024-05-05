local telescope_builtin = require('telescope.builtin')

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'file_browser')

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<c-j>'] = require('telescope.actions').move_selection_next,
        ['<c-k>'] = require('telescope.actions').move_selection_previous,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = 'ivy',
      hijack_netrw = true,
      no_ignore = true,
      hidden = true,
      mappings = {
        ['i'] = {},
        ['n'] = {},
      },
    },
  },
})

local ripgrep = {
  'rg',
  '--files',
}

local ignored = {
  '--iglob',
  '!.git',
  '--iglob',
  '!node_modules',
  '--iglob',
  '!dist',
  '--iglob',
  '!build',
  '--iglob',
  '!zig-out',
  '--iglob',
  '!zig-cache',
  '--iglob',
  '!target',
}

local options = {
  '--hidden',
  '--no-ignore',
}

local merge = function(t1, ...)
  for _, new in ipairs({ ... }) do
    for _, v in ipairs(new) do
      table.insert(t1, v)
    end
  end
  return t1
end

local find_files = function()
  telescope_builtin.find_files({
    find_command = merge(ripgrep, ignored, options),
  })
end

local live_grep = function()
  telescope_builtin.live_grep({
    additional_args = merge(ignored, options),
  })
end

vim.keymap.set('n', '<leader>ff', find_files, {})
vim.keymap.set('n', '<leader>fg', live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
vim.keymap.set('n', '<leader>ft', function()
  require('telescope').extensions.file_browser.file_browser()
end)
