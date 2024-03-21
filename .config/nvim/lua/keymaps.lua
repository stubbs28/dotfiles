-- window navigation
vim.keymap.set('n', '<C-j>', '<C-w>j', {})
vim.keymap.set('n', '<C-k>', '<C-w>k', {})
vim.keymap.set('n', '<C-h>', '<C-w>h', {})
vim.keymap.set('n', '<C-l>', '<C-w>l', {})
-- buffer navigation
vim.keymap.set('n', '<leader>l', '<cmd>bnext<cr>', {})
vim.keymap.set('n', '<leader>h', '<cmd>bprevious<cr>', {})
-- quickfix navigation
vim.keymap.set('n', '<C-n>', '<cmd>cnext<cr>', {})
vim.keymap.set('n', '<C-m>', '<cmd>cprevious<cr>', {})
vim.keymap.set('n', '<leader>a', '<cmd>cclose<cr>', {})
-- send errors to quickfix list
vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', {})
