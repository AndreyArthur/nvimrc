local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
local completion_capabilities = require('plugins.completion')

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  completion_capabilities
)

local hover = function()
  return vim.lsp.buf.hover({
    border = 'rounded',
  })
end

local signature_help = function()
  return vim.lsp.buf.signature_help({
    border = 'solid',
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', hover, opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set(
      'n',
      '<leader>gi',
      '<cmd>lua vim.lsp.buf.implementation()<cr>',
      opts
    )
    vim.keymap.set(
      'n',
      'go',
      '<cmd>lua vim.lsp.buf.type_definition()<cr>',
      opts
    )
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', signature_help, opts)
    vim.keymap.set('i', '<c-;>', signature_help, opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set(
      { 'n', 'x' },
      '<F3>',
      '<cmd>lua vim.lsp.buf.format({ async = true })<cr>',
      opts
    )
    vim.keymap.set(
      'n',
      '<F4>',
      '<cmd>lua vim.lsp.buf.code_action({ apply = true })<cr>',
      opts
    )

    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  end,
})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})
lspconfig.gopls.setup({})
lspconfig.clangd.setup({})
lspconfig.pyright.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.ts_ls.setup({})
