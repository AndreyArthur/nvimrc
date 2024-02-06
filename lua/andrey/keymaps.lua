local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Remap space as leader key
keymap('', '<space>', '<nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --

-- Repeat last macro to pattern
keymap('n', '<leader>,', 'N@@', opts)
keymap('n', '<leader>.', 'n@@', opts)

--  Use system clipboard
keymap('n', '<leader>y', '"+y', opts)
keymap('n', '<leader>p', '"+p', opts)
keymap('n', '<leader>P', '"+P', opts)

-- Navigate between buffers and tabs
keymap('n', '<leader>bh', ':bprevious<cr>', opts)
keymap('n', '<leader>bl', ':bnext<cr>', opts)
keymap('n', '<leader>bn', ':enew<cr>', opts)
keymap('n', '<leader>bd', ':bdelete<cr>', opts)
keymap('n', '<leader>th', 'gT', opts)
keymap('n', '<leader>tl', 'gt', opts)
keymap('n', '<leader>tn', ':tabnew<cr>', opts)

-- Enter in terminal mode
keymap('n', '<leader>tt', ':terminal<cr>', opts)

-- Use virtual navigation
keymap('n', 'k', 'gk', opts)
keymap('n', 'j', 'gj', opts)

-- Delete to void
keymap('n', '<leader>d', '"_d', opts)

-- Register...
keymap('n', '<leader>r', '"', opts)

-- Edit from current file path
keymap('n', '<leader>E', ":let @-=expand('%:p:h')<cr> :e <c-r>-/", {
  noremap = true,
  silent = false,
})

keymap('n', '<leader>e', ':Explore<cr>', opts)

-- Insert --

-- hjkl navigation in insert mode
keymap('i', '<c-k>', '<up>', opts)
keymap('i', '<c-j>', '<down>', opts)
keymap('i', '<c-h>', '<left>', opts)
keymap('i', '<c-l>', '<right>', opts)

-- Visual --

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

--  Use system clipboard
keymap('v', '<leader>y', '"+y', opts)
keymap('v', '<leader>p', '"+p', opts)

-- Delete to void
keymap('v', '<leader>d', '"_d', opts)

-- Move blocks of text
keymap('v', '<c-j>', ":m '>+1<CR>gv=gv", opts)
keymap('v', '<c-k>', ":m '<-2<CR>gv=gv", opts)

keymap('v', 'k', 'gk', opts)
keymap('v', 'j', 'gj', opts)

-- Command --

keymap('c', '<c-h>', '<left>', { noremap = true })
keymap('c', '<c-j>', '<down>', { noremap = true })
keymap('c', '<c-k>', '<up>', { noremap = true })
keymap('c', '<c-l>', '<right>', { noremap = true })
