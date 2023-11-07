if not vim.g.neovide then
  require('neoscroll').setup({
    mappings = {
      '<C-u>',
      '<C-d>',
      '<C-b>',
      '<C-f>',
      '<C-y>',
      '<C-e>',
      'zt',
      'zz',
      'zb',
    },
    hide_cursor = false,
    stop_eof = true,
    respect_scrolloff = false,
    cursor_scrolls_alone = true,
    easing_function = nil,
    pre_hook = nil,
    post_hook = nil,
    performance_mode = false,
  })

  local mappings = {}

  mappings['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '200' } }
  mappings['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '200' } }
  mappings['<C-b>'] =
    { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '350' } }
  mappings['<C-f>'] =
    { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '350' } }
  mappings['<C-y>'] = { 'scroll', { '-1', 'false', '100' } }
  mappings['<C-e>'] = { 'scroll', { '1', 'false', '100' } }
  mappings['zt'] = { 'zt', { '250' } }
  mappings['zz'] = { 'zz', { '250' } }
  mappings['zb'] = { 'zb', { '250' } }

  require('neoscroll.config').set_mappings(mappings)
end
