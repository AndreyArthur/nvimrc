local filter_out = function(complete_table, filter)
  local has_value = function(tbl, value)
    for _, v in ipairs(tbl) do
      if v == value then
        return true
      end
    end
    return false
  end

  local new_table = {}
  local index = 1

  for _, v in ipairs(complete_table) do
    if not has_value(filter, v) then
      new_table[index] = v
      index = index + 1
    end
  end

  return new_table
end

local colorschemes = vim.fn.getcompletion('', 'color')

require('huez').setup({
  omit = filter_out(colorschemes, {
    'catppuccin-frappe',
    'catppuccin-latte',
    'catppuccin-macchiato',
    'catppuccin-mocha',
    'github_dark',
    'github_dark_dimmed',
    'github_light',
    'kanagawa-dragon',
    'kanagawa-lotus',
    'kanagawa-wave',
    'onedark-cool',
    'onedark-dark',
    'onedark-darker',
    'onedark-deep',
    'onedark-light',
    'onedark-warm',
    'onedark-warmer',
    'tokyonight-day',
    'tokyonight-moon',
    'tokyonight-night',
    'tokyonight-storm',
  }),
  picker = 'telescope',
  picker_opts = require('telescope.themes').get_ivy({}),
})

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
