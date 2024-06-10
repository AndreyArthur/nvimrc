local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

local except = function(colorschemes)
  local has_value = function(tbl, value)
    for _, v in ipairs(tbl) do
      if v == value then
        return true
      end
    end
    return false
  end

  local vim_colorschemes = vim.fn.getcompletion('', 'color')
  local new_table = {}
  local index = 1

  for _, v in ipairs(vim_colorschemes) do
    if not has_value(colorschemes, v) then
      new_table[index] = v
      index = index + 1
    end
  end

  return new_table
end

telescope.setup({
  defaults = require('telescope.themes').get_ivy({
    mappings = {
      i = {
        ['<c-j>'] = require('telescope.actions').move_selection_next,
        ['<c-k>'] = require('telescope.actions').move_selection_previous,
      },
    },
  }),
  pickers = {},
  extensions = {
    themes = {
      ignore = except({
        'catppuccin-frappe',
        'catppuccin-latte',
        'catppuccin-macchiato',
        'catppuccin-mocha',
        'onedark',
        'onelight',
        'onedark_vivid',
        'tokyonight-day',
        'tokyonight-moon',
        'tokyonight-night',
        'tokyonight-storm',
      }),
      enable_live_preview = true,
      enable_previewer = false,
      persist = {
        enabled = true,
        path = vim.fn.stdpath('config') .. '/lua/colorscheme.lua',
      },
    },
    file_browser = {
      initial_mode = 'normal',
      cwd_to_path = true,
      hijack_netrw = true,
      no_ignore = true,
      hidden = true,
      grouped = true,
      mappings = {
        ['i'] = {
          ['<bs>'] = false,
        },
        ['n'] = {},
      },
    },
  },
})

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'file_browser')
pcall(telescope.load_extension, 'themes')

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
vim.keymap.set(
  'n',
  '<leader>fe',
  function() telescope.extensions.file_browser.file_browser({ path = '%:p:h' }) end
)
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope themes<cr>', {})
