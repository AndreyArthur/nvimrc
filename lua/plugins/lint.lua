local none_ls = require('null-ls')

none_ls.setup({
  sources = {
    none_ls.builtins.formatting.stylua,
    none_ls.builtins.formatting.gofmt,
    none_ls.builtins.formatting.clang_format.with({
      filetypes = { 'c', 'cpp' },
    }),
    none_ls.builtins.formatting.black,
  },
})

local is_null_ls_active = function()
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == 'null-ls' then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    if is_null_ls_active() then
      vim.lsp.buf.format({
        filter = function(client) return client.name == 'null-ls' end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  command = 'silent! EslintFixAll',
  group = vim.api.nvim_create_augroup('EslintFormat', {}),
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.rs' },
  command = 'lua vim.lsp.buf.format()',
  group = vim.api.nvim_create_augroup('RustAnalyzerFormat', {}),
})
