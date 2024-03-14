local lsp_configs = {
     'go'
}

local nvim_lsp = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_signature = require('lsp_signature')

function setup_lsp(server, lsp_opts)
	lsp_opts.on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		-- Enable completion trigered by <c-x><c-o>
		buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
		local opts = { noremap = true, silent = true}

		-- Keybindings
		--  K            Documentation
		--  <leader>d    Go to definition
		--  <leader>rn   Rename
		--  <leader>ca   Code action
		--  <leader>f    Format

		buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
		buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
		buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
	end

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
