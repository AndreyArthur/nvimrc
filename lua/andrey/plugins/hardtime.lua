local hardtime = require('hardtime')

hardtime.setup({
  max_count = 4,
  disabled_filetypes = {
    'qf',
    'netrw',
    'NvimTree',
    'lazy',
    'mason',
    'fugitive'
  },
})
