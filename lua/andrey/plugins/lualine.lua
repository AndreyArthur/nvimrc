local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

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

local location = {
  'location',
  fmt = function(str)
    return str .. ' '
  end,
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

local identation = function()
  return 'identation: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

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
    lualine_y = { diff, identation, 'filesize', 'selectioncount' },
    lualine_z = { 'filename', location, progress },
  },
  inactive_sections = {
    lualine_a = { branch, diagnostics },
    lualine_b = { mode },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'encoding', 'filename', filetype },
    lualine_z = { location },
  },
  tabline = {
    lualine_a = { filetype, 'encoding' },
    lualine_b = { 'branch', 'fileformat' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { { 'buffers', max_length = vim.o.columns / 4 } },
    lualine_z = { 'hostname', 'tabs' },
  },
  extensions = { 'nvim-tree' },
})
