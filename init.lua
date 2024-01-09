require('andrey.config')
require('andrey.keymaps')
require('andrey.plugins')
require('andrey.plugins.load')
require('andrey.colorscheme')
require('andrey.terminal')
require('andrey.gui')

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
