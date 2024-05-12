local ensure_config_exists = function()
  local filepath = '~/.config/nvim/.nvim.huez.lua'
  local status = os.execute('cat ' .. filepath)
  local exists = true

  if status == 256 then
    exists = false
  end

  if not exists then
    local status_ok, _ = pcall(require, 'tokyonight')

    if status_ok then
      os.execute("echo 'tokyonight' > " .. filepath)
    else
      os.execute("echo 'slate' > " .. filepath)
    end
  end
end

ensure_config_exists()

local colorscheme = require('huez.api').get_colorscheme()
vim.cmd('colorscheme ' .. colorscheme)

vim.keymap.set('n', '<leader>fc', '<cmd>Huez<cr>', {})