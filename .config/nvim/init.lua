local lsp_modules = {
  'plug',
  'options',
  'configs',
  'lsp',
  'keymaps',
  'autocmds'
}

vim.env.PATH = vim.env.VIM_PATH or vim.env.PATH

for _, m in pairs(lsp_modules) do
	require(m)
end
