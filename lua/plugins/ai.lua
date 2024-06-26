vim.g.codeium_disable_bindings = 1

vim.cmd('CodeiumDisable')

vim.keymap.set(
  'i',
  '<c-f>t',
  function() return vim.cmd('CodeiumToggle') end,
  { expr = true, silent = true }
)
vim.keymap.set(
  'i',
  '<c-f><c-t>',
  function() return vim.cmd('CodeiumToggle') end,
  { expr = true, silent = true }
)

vim.keymap.set(
  'i',
  '<c-f>h',
  function() return vim.fn['codeium#Clear']() end,
  { expr = true, silent = true }
)
vim.keymap.set(
  'i',
  '<c-f><c-h>',
  function() return vim.fn['codeium#Clear']() end,
  { expr = true, silent = true }
)

vim.keymap.set(
  'i',
  '<c-f>j',
  function() return vim.fn['codeium#CycleCompletions'](1) end,
  { expr = true, silent = true }
)
vim.keymap.set(
  'i',
  '<c-f><c-j>',
  function() return vim.fn['codeium#CycleCompletions'](1) end,
  { expr = true, silent = true }
)

vim.keymap.set(
  'i',
  '<c-f>k',
  function() return vim.fn['codeium#CycleCompletions'](-1) end,
  { expr = true, silent = true }
)
vim.keymap.set(
  'i',
  '<c-f><c-k>',
  function() return vim.fn['codeium#CycleCompletions'](-1) end,
  { expr = true, silent = true }
)

vim.keymap.set(
  'i',
  '<c-f>l',
  function() return vim.fn['codeium#Accept']() end,
  { expr = true, silent = true }
)
vim.keymap.set(
  'i',
  '<c-f><c-l>',
  function() return vim.fn['codeium#Accept']() end,
  { expr = true, silent = true }
)
