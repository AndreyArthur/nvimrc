local splitjoin = require('mini.splitjoin')
local indent_blankline = require('ibl')

splitjoin.setup({
  mappings = {
    toggle = '<leader>ss',
    split = '',
    join = '',
  },
})

indent_blankline.setup({
  indent = {
    char = '▏',
  },
  scope = {
    enabled = false,
  },
})
