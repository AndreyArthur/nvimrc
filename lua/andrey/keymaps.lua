local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
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

--  Use system clipboard
keymap('n', '<leader>y', '"+y', opts)
keymap('n', '<leader>p', '"+p', opts)

-- Visual --

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
--  Use system clipboard
keymap('v', '<leader>y', '"+y', opts)
keymap('v', '<leader>p', '"+p', opts)

-- Plugins --

-- Nvim Tree --
keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)
