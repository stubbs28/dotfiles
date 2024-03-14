local config_modules = {
  '_close-buffers',
  '_lualine',
  '_markdown-preview',
  '_nvim-cmp',
  '_nvim-tree',
  '_nvim-treesitter',
  '_remember',
  '_trim',
  '_ultisnips',
  '_vim-go'
}

for _, m in pairs(config_modules) do
	require('configs.'..m)
end
