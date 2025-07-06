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

local format = function() vim.lsp.buf.format({ async = true }) end

local code_actions = function() return vim.lsp.buf.code_action({ apply = true }) end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', signature_help, opts)
    vim.keymap.set('i', '<c-;>', signature_help, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', format, opts)
    vim.keymap.set('n', '<F4>', code_actions, opts)

    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  group = vim.api.nvim_create_augroup('JavaConfig', { clear = true }),
  callback = function(opts)
    local config = {
      cmd = { '/usr/bin/jdtls' },
      settings = {
        ['java.format.settings.url'] = vim.fn.expand('~/Documents/format.xml'),
      },
      root_dir = vim.fs.dirname(
        vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]
      ),
    }
    require('jdtls').start_or_attach(config)

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.java' },
      command = 'lua vim.lsp.buf.format()',
      group = vim.api.nvim_create_augroup('JdtlsFormat', {}),
    })
  end,
})
