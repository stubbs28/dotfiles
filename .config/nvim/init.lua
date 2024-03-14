local lsp_modules = {
  'plug',
  'options',
  'configs',
  'lsp',
  'keymaps',
  'autocmds'
}

for _, m in pairs(lsp_modules) do
	require(m)
end
