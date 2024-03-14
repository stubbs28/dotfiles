require('close_buffers').setup({
  preserve_window_layout = { 'this' },
})
vim.api.nvim_set_keymap(
  'n',
  '<leader>bd',
  [[<CMD>lua require('close_buffers').delete({type = 'this'})<CR>]],
  { noremap = true, silent = true }
)

-- bdelete
-- require('close_buffers').delete({ type = 'hidden', force = true }) -- Delete all non-visible buffers
-- require('close_buffers').delete({ type = 'nameless' }) -- Delete all buffers without name
-- require('close_buffers').delete({ type = 'this' }) -- Delete the current buffer
-- require('close_buffers').delete({ type = 1 }) -- Delete the specified buffer number
-- require('close_buffers').delete({ regex = '.*[.]md' }) -- Delete all buffers matching the regex

-- bwipeout
-- require('close_buffers').wipe({ type = 'all', force = true }) -- Wipe all buffers
-- require('close_buffers').wipe({ type = 'other' }) -- Wipe all buffers except the current focused
-- require('close_buffers').wipe({ type = 'hidden', glob = '*.lua' }) -- Wipe all buffers matching the glob
