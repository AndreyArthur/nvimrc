local cmp = require('cmp')

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
cmp_capabilities.textDocument.completion.completionItem.snippetSupport = false

local kind_icons = {
  Text = ' ',
  Method = '󰆧 ',
  Function = '󰘧 ',
  Constructor = ' ',
  Field = '󰇽 ',
  Variable = '󰂡 ',
  Class = '󰠱 ',
  Interface = ' ',
  Module = ' ',
  Property = '󰜢 ',
  Unit = ' ',
  Value = '󰎠 ',
  Enum = ' ',
  Keyword = '󰌋 ',
  Snippet = ' ',
  Color = '󰏘 ',
  File = '󰈙 ',
  Reference = ' ',
  Folder = '󰉋 ',
  EnumMember = ' ',
  Constant = '󰏿 ',
  Struct = ' ',
  Event = ' ',
  Operator = '󰆕 ',
  TypeParameter = '󰅲 ',
}

require('snippy').setup({})

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
    expand = function(args) require('snippy').expand_snippet(args.body) end,
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
        nvim_lua = '[Lua]',
        latex_symbols = '[LaTeX]',
      })[entry.source.name]
      return vim_item
    end,
  },
})

return {
  cmp_capabilities,
}
