require('window-picker').setup({
  selection_chars = 'HJKLABCDEFGIMNOPQRSTUVWXYZ',
  autoselect_one = true,
  include_current = false,
  filter_rules = {
    bo = {
      filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
      buftype = { 'terminal', 'quickfix' },
    },
  },
  other_win_hl_color = '#7aa2f7',
})

require('neo-tree').setup({
  window = {
    width = 32,
    mappings = {
      ['<cr>'] = 'open',
      ['o'] = 'open_with_window_picker',
      ['s'] = 'split_with_window_picker',
      ['v'] = 'vsplit_with_window_picker',
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
    },
    group_empty_dirs = false,
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ['h'] = {
          'show_help',
          nowait = false,
          config = { title = 'Order by', prefix_key = 'o' },
        },
      },
    },
  },
})

vim.keymap.set(
  'n',
  '<leader>e',
  ':Neotree toggle<cr>',
  { noremap = true, silent = true }
)
