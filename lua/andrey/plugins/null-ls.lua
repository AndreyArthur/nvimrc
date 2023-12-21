local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.gofmt,
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
      vim.lsp.buf.format()
    end
  end,
})
