local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

local hide_in_width = function() return vim.fn.winwidth(0) > 80 end

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn', 'info', 'hint' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  'diff',
  colored = false,
  symbols = { added = '+ ', modified = '~ ', removed = '- ' }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  'mode',
  fmt = function(str)
    local lower_mode = str:lower()
    if lower_mode == 'v-line' then
      return 'visual line'
    end
    if lower_mode == 'v-block' then
      return 'visual block'
    end
    return lower_mode
  end,
}

local filetype = {
  'filetype',
  icons_enabled = true,
  icon = nil,
}

local branch = {
  'branch',
  icons_enabled = true,
  icon = '',
}

local trim = function(s)
  return string.match(s, '^()%s*$') and '' or string.match(s, '^%s*(.*%S)')
end

local location = {
  'location',
  fmt = function(str) return ' ' .. trim(str) .. ' ' end,
  padding = 0,
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  local chars = {
    '  ',
    '▁▁',
    '▂▂',
    '▃▃',
    '▄▄',
    '▅▅',
    '▆▆',
    '▇▇',
    '██',
  }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local indentation = function()
  return 'indent: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

local buffers = {
  'buffers',
  buffers_color = {
    active = function()
      local mode_names = {
        n = 'lualine_b_normal',
        i = 'lualine_b_insert',
        v = 'lualine_b_visual',
        V = 'lualine_b_visual',
        R = 'lualine_b_replace',
      }
      local nvim_mode = vim.api.nvim_get_mode().mode
      return mode_names[nvim_mode]
    end,
  },
  max_length = vim.o.columns / 4,
}

local tabs = {
  'tabs',
  symbols = {
    modified = ' ●',
  },
  use_mode_colors = true,
}

local filename = {
  'filename',
  symbols = {
    modified = '●',
    readonly = '!',
    newfile = '+',
    unnamed = '~',
  },
}

local hostname = {
  'hostname',
  separator = '',
  fmt = function(str)
    local separator = ''
    if vim.fn.tabpagenr() == 1 then
      separator = ' '
    else
      separator = ' '
    end

    return ' ' .. str .. separator
  end,
  padding = 0,
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'dashboard', 'Outline' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch, diagnostics },
    lualine_b = { mode },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { diff, indentation, 'filesize', 'selectioncount' },
    lualine_z = { filename, location, progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { diagnostics, mode },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { diff, filename, location },
    lualine_z = {},
  },
  tabline = {
    lualine_a = { filetype, 'encoding' },
    lualine_b = { 'branch', 'fileformat' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { buffers },
    lualine_z = { hostname, tabs },
  },
})
