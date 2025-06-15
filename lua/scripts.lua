vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function() vim.api.nvim_set_current_dir(vim.fn.expand('%:p:h')) end,
})

vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})

vim.api.nvim_create_autocmd('UILeave', {
  callback = function() io.write('\027]111\027\\') end,
})

local source = function()
  local command = 'find ~/.config/nvim/lua/**/* ~/.config/nvim/init.lua -type f'
  local output = io.popen(command)
  if output == nil then
    return
  end
  local files_string = output:read('*a')
  output:close()
  local files = {}
  for line in files_string:gmatch('[^\n]+') do
    table.insert(files, line)
  end
  for _, file in ipairs(files) do
    vim.cmd('source ' .. file)
  end
end

vim.keymap.set('n', '<leader><F5>', source, { silent = true, noremap = true })
