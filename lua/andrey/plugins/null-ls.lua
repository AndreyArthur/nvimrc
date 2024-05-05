local null_ls = require('null-ls')

local file_exists = function(file)
  local f = io.open(file, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local eslint_config = {
  extra_args = function(params)
    local file_types = { 'js', 'cjs', 'yaml', 'yml', 'json' }
    for _, file_type in pairs(file_types) do
      if file_exists(params.root .. '/.eslintrc.' .. file_type) then
        return {}
      end
    end

    return {
      '--no-config-lookup',
    }
  end,
}

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint_d.with(eslint_config),
    null_ls.builtins.formatting.eslint_d.with(eslint_config),
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.clang_format,
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
