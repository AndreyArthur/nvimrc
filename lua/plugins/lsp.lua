local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
local completion_capabilities = require('plugins.completion')

vim.lsp.handlers['textDocument/hover'] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  completion_capabilities
)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
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
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set(
      'i',
      '<c-;>',
      '<cmd>lua vim.lsp.buf.signature_help()<cr>',
      opts
    )
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

local default_setup = function(server) lspconfig[server].setup({}) end

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'clangd',
    'lua_ls',
  },
  handlers = {
    default_setup,
    lua_ls = function()
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })
    end,
    eslint = function()
      lspconfig.eslint.setup({
        settings = {
          codeActionOnSave = {
            enable = true,
            mode = 'all',
          },
        },
      })
    end,
  },
})

vim.g.zig_fmt_parse_errors = 0
