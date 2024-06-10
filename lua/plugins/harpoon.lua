local harpoon = require('harpoon')

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

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<leader>hh', function() harpoon:list():prev() end)
vim.keymap.set('n', '<leader>hl', function() harpoon:list():next() end)
