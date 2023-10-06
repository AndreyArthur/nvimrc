require('lint').linters_by_ft = {
  lua = {
    'luacheck',
  },
  javascript = {
    'eslint',
  },
  typescript = {
    'eslint',
  },
  javascriptreact = {
    'eslint',
  },
  tyescriptreact = {
    'eslint',
  },
}

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})


