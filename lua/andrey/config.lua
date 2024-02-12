local options = {
  backup = false, -- avoid vim backup files
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = 'utf-8', -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  mouse = '', -- disable mouse
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- avoid creating a swapfile
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 4
  hidden = false, -- does not allow to exit the buffer without saving
  colorcolumn = { 81, 121 }, -- columns to indicate 80 and 120 characters
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  linebreak = true, -- if wrap is true, don't split words
  scrolloff = 4, -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 4, -- minimal number of screen columns either side of cursor if wrap is `false`
  background = 'dark', -- just for some especific themes
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Highlight yanked text
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({
      \ higroup = 'Visual',
      \ timeout = 150,
    \ })
  augroup end
]])

-- Wrap in markdown files
vim.cmd('au BufRead,BufNewFile *.md setlocal wrap')

-- Set ejs files to html
vim.cmd('au BufRead,BufNewFile *.ejs set filetype=html')
