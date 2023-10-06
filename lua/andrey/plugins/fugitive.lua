local toggle_fugitive = function ()
  if (vim.bo.filetype == 'fugitive') then
    vim.cmd('quit')
    return
  end
  vim.cmd('Git')
end

vim.keymap.set('n', '<leader>g', toggle_fugitive, { noremap = true })
