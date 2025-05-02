local signs = {
  Error = '',
  Warning = '',
  Hint = '󰌵',
  Information = '',
}

local format = function(diagnostic)
  if diagnostic.severity == vim.diagnostic.severity.WARN then
    return string.format(signs.Warning .. ' %s', diagnostic.message)
  elseif diagnostic.severity == vim.diagnostic.severity.ERROR then
    return string.format(signs.Error .. ' %s', diagnostic.message)
  elseif diagnostic.severity == vim.diagnostic.severity.INFO then
    return string.format(signs.Information .. ' %s', diagnostic.message)
  elseif diagnostic.severity == vim.diagnostic.severity.HINT then
    return string.format(signs.Hint .. ' %s', diagnostic.message)
  end
  return diagnostic.message
end

vim.diagnostic.config({
  virtual_text = {
    source = false,
    prefix = '',
    format = format,
  },
  float = {
    border = 'rounded',
    header = '',
    prefix = '',
    source = true,
    format = format,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.WARN] = signs.Warning,
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.INFO] = signs.Information,
      [vim.diagnostic.severity.HINT] = signs.Hint,
    },
  },
})
