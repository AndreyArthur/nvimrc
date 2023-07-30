local lsp = require('lsp-zero')
local cmp = require('cmp')

-- K: Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
-- gd: Jumps to the definition of the symbol under the cursor. See :help vim.lsp.buf.definition().
-- gD: Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature. See :help vim.lsp.buf.declaration().
-- go: Jumps to the definition of the type of the symbol under the cursor. See :help vim.lsp.buf.type_definition().
-- gr: Lists all the references to the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.references().
-- <Ctrl-k>: Displays signature information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.signature_help(). If a mapping already exists for this key this function is not bound.
-- <F2>: Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
-- <F4>: Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
-- gl: Show diagnostics in a floating window. See :help vim.diagnostic.open_float().
-- [d: Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
-- ]d: Move to the next diagnostic. See :help vim.diagnostic.goto_next().

lsp.preset('recommended')
lsp.set_preferences({
  set_lsp_keymaps = {
    omit = {
      'gi',
    },
  }
});
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
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
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
});
lsp.setup()
