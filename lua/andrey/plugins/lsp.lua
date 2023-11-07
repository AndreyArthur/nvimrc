local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
local cmp = require('cmp')

-- Vim diagnostics and floating windows configuration
vim.diagnostic.config({
  virtual_text = {
    source = false,
    prefix = '',
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.WARN then
        return string.format('  %s', diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.ERROR then
        return string.format(' %s', diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        return string.format(' %s', diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        return string.format('󰌵 %s', diagnostic.message)
      end
      return diagnostic.message
    end,
  },
  float = {
    border = 'rounded',
    header = '',
    prefix = '',
    source = true,
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.WARN then
        return string.format('  %s', diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.ERROR then
        return string.format(' %s', diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        return string.format(' %s', diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        return string.format('󰌵 %s', diagnostic.message)
      end
      return diagnostic.message
    end,
  },
})

vim.lsp.handlers['textDocument/hover'] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
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

local default_setup = function(server)
  lspconfig[server].setup({})
end

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
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

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  command = 'silent! EslintFixAll',
  group = vim.api.nvim_create_augroup('MyAutocmdsJavaScriptFormatting', {}),
})

local kind_icons = {
  Text = '',
  Method = '󰆧',
  Function = '󰘧',
  Constructor = '',
  Field = '󰇽',
  Variable = '󰂡',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '󰅲',
}

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<c-k>'] = cmp.mapping.select_prev_item(),
    ['<c-j>'] = cmp.mapping.select_next_item(),
    ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<c-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<c-y>'] = cmp.config.disable,
    ['<c-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<tab>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind =
        string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[LaTeX]',
      })[entry.source.name]
      return vim_item
    end,
  },
})
