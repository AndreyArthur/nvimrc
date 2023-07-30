local nvim_lint = require('lint')

nvim_lint.linters_by_ft = {
  javascript = {'eslint'},
  lua = {'luacheck'}
}

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    nvim_lint.try_lint()
  end,
})
