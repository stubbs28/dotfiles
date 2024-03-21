local lsp_configs = {
     'go'
}

local nvim_lsp = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_signature = require('lsp_signature')
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer=bufnr }

	-- Enable completion trigered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	--  K            Documentation
	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	--  <leader>d    Go to definition
	vim.keymap.set('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	--  <leader>rn   Rename
	vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	--  <leader>ca   Code action
	vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	--  <leader>f    Format
	vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
end

function setup_lsp(server, lsp_opts)
	lsp_opts.on_attach = on_attach
	lsp_opts.capabilities = lsp_capabilities
	lsp_opts.flags = {
		-- Don't spam LSP with changes. Wait a second between updates.
		debounce_text_changes = 1000,
	}

	nvim_lsp[server].setup(lsp_opts)
end

-- LSP implementations that don't need any configuration.
local default_lsps = {
	'clojure_lsp',
	'hie',
	'pylsp',
	'zls',
	'jsonls'
}

for _, server in pairs(default_lsps) do
	setup_lsp(server, {})
end

for _, m in pairs(lsp_configs) do
	require('lsp.'..m)
end
