local hardtime = require('hardtime')

hardtime.setup({
  max_count = 10,
  max_time = 500,
  allow_different_key = true,
  disabled_filetypes = {
    'neo-tree',
    'qf',
    'netrw',
    'NvimTree',
    'lazy',
    'mason',
    'fugitive'
  },
})
