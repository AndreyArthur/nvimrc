local harpoon = require('harpoon')
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

local filter_except = function(original_table, exceptions)
  local has_value = function(tbl, value)
    for _, v in ipairs(tbl) do
      if v == value then
        return true
      end
    end
    return false
  end

  local new_table = {}
  local index = 1

  for _, v in ipairs(original_table) do
    if not has_value(exceptions, v) then
      new_table[index] = v
      index = index + 1
    end
  end

  return new_table
end

local themes_config = {
  ignore = filter_except(vim.fn.getcompletion('', 'color'), {
    'catppuccin-frappe',
    'catppuccin-latte',
    'catppuccin-macchiato',
    'catppuccin-mocha',
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
}

local file_browser_config = {
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
}

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
    themes = themes_config,
    file_browser = file_browser_config,
  },
})

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'file_browser')
pcall(telescope.load_extension, 'themes')

local ripgrep = {
  'rg',
  '--files',
}

local ignore = function(table)
  local ignored = {}
  local i = 1
  for _, v in ipairs(table) do
    ignored[i] = '--iglob'
    ignored[i + 1] = '!' .. v
    i = i + 2
  end
  return ignored
end

local ignored = ignore({
  '.git',
  'node_modules',
  'obj',
  'bin',
  'dist',
  'build',
  'zig-out',
  'zig-cache',
  'target',
})

local options = {
  '--hidden',
  '--no-ignore',
}

local merge = function(into, ...)
  for _, new in ipairs({ ... }) do
    for _, v in ipairs(new) do
      table.insert(into, v)
    end
  end
  return into
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

harpoon:setup()

local default_config = require('telescope.config').values

local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Harpoon',
      finder = require('telescope.finders').new_table({
        results = file_paths,
      }),
      previewer = default_config.file_previewer({}),
      sorter = default_config.generic_sorter({}),
    })
    :find()
end

vim.keymap.set(
  'n',
  '<leader>fh',
  function() toggle_telescope(harpoon:list()) end,
  { desc = 'Open harpoon window' }
)

vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end)

vim.keymap.set('n', '<leader>h1', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<leader>h2', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<leader>h3', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<leader>h4', function() harpoon:list():select(4) end)
vim.keymap.set('n', '<leader>h5', function() harpoon:list():select(5) end)
vim.keymap.set('n', '<leader>h6', function() harpoon:list():select(6) end)
vim.keymap.set('n', '<leader>h7', function() harpoon:list():select(7) end)
vim.keymap.set('n', '<leader>h8', function() harpoon:list():select(8) end)
vim.keymap.set('n', '<leader>h9', function() harpoon:list():select(9) end)
vim.keymap.set('n', '<leader>h0', function() harpoon:list():select(10) end)

vim.keymap.set('n', '<leader>hh', function() harpoon:list():prev() end)
vim.keymap.set('n', '<leader>hl', function() harpoon:list():next() end)
