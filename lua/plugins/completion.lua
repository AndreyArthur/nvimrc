local blink = require('blink.cmp')

local capabilities = blink.get_lsp_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

blink.setup({
  term = {
    enabled = false,
  },
  keymap = {
    preset = 'none',
    ['<c-k>'] = { 'select_prev' },
    ['<c-j>'] = { 'select_next' },
    ['<c-space>'] = { 'show' },
    ['<tab>'] = {
      'accept',
      'fallback',
    },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      window = { border = 'rounded' },
    },
    menu = {
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'kind_icon', 'kind', gap = 1 },
        },
      },
    },
  },
  sources = {
    default = function(_) return { 'lsp', 'path', 'snippets', 'buffer' } end,
    transform_items = function(_, items)
      return vim.tbl_filter(
        function(item)
          return item.kind
            ~= require('blink.cmp.types').CompletionItemKind.Snippet
        end,
        items
      )
    end,
    providers = {
      lsp = {
        module = 'blink.cmp.sources.lsp',
        fallbacks = {},
      },
      buffer = {
        module = 'blink.cmp.sources.buffer',
        score_offset = -5,
      },
    },
  },
  fuzzy = {
    implementation = 'prefer_rust',
    max_typos = function(keyword) return math.floor(#keyword / 4) end,
    use_frecency = true,
    use_proximity = true,
    use_unsafe_no_lock = false,
    sorts = {
      'score',
      'sort_text',
    },
  },
})

return capabilities
