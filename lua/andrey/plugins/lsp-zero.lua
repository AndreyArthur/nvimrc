local lsp = require('lsp-zero')
local cmp = require('cmp')


lsp.preset('recommended')
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim'}
      }
    }
  }
})
lsp.setup_nvim_cmp({
  mapping = {
    ['<c-k>'] = cmp.mapping.select_prev_item(),
		['<c-j>'] = cmp.mapping.select_next_item(),
    ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<c-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<c-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<c-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<tab>'] = cmp.mapping.confirm { select = true },
  },
});
lsp.setup()
