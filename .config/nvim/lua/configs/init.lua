local config_modules = {
  '_close-buffers',
  '_fidget',
  '_lualine',
  '_markdown-preview',
  '_nvim-cmp',
  '_nvim-tree',
  '_nvim-treesitter',
  '_remember',
  '_snippy',
  '_trim',
  '_vim-go'
}

for _, m in pairs(config_modules) do
	require('configs.'..m)
end
