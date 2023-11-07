local dap = require('dap')
local dapui = require('dapui')

require('mason-nvim-dap').setup({
  automatic_setup = true,
  handlers = {},
  ensure_installed = {
    'delve',
  },
})

vim.keymap.set(
  'n',
  '<leader>ll',
  dap.continue,
  { desc = 'Debug: Start/Continue' }
)
vim.keymap.set('n', '<leader>lk', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<leader>lj', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<leader>le', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set(
  'n',
  '<leader>lb',
  dap.toggle_breakpoint,
  { desc = 'Debug: Toggle Breakpoint' }
)
vim.keymap.set('n', '<leader>lB', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Debug: Set Breakpoint' })

dapui.setup({
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '>>',
      step_out = '<<',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
})

vim.keymap.set(
  'n',
  '<leader>lu',
  dapui.toggle,
  { desc = 'Debug: See last session result.' }
)

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
