function _G.setup_terminal()
  local opts = {noremap = true}
  vim.api.nvim_command('startinsert')
  vim.api.nvim_command('setlocal nonumber norelativenumber')
  vim.api.nvim_command('setlocal signcolumn=no')
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua setup_terminal()')
