require('onedark').setup({
  style = 'warm', -- dark, darker, cool, deep, warm or warmer
})
require('tokyonight').setup({
  style = 'moon', -- storm, night, moon, or day
})
require('gruvbox').setup({
  constrast = 'hard', -- hard, soft or <empty>
})
require('kanagawa').load('lotus') -- wave, dragon or lotus

local colorscheme = 'tokyonight'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  return
end
