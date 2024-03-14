vim.g.go_def_mapping_enabled = 0
vim.g.go_code_completion_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_metalinter_autosave_enabled = {}
vim.g.go_gopls_enabled = 0
vim.g.go_term_enabled = 1
vim.g.go_term_reuse = 1
vim.g.go_term_mode = "split"
-- vim.g.go_template_file = vim.env.HOME .. "/.config/vim-go/main.go"
-- vim.g.go_template_test_file = vim.env.HOME .. "/.config/vim-go/test.go"
if vim.env.VIM_GO_BIN_PATH then
	vim.g.go_bin_path = vim.env.VIM_GO_BIN_PATH
end
-- Support disabling gopls and LSP by setting an environment variable,
-- and in diff mode.
local disable_gopls = vim.env.VIM_GOPLS_DISABLED or vim.opt.diff:get()

local gopls_options = {
	gofumpt         = true,
	staticcheck     = true,
	usePlaceholders = true,
}

-- Support overriding memory mode with an environment variable.
if vim.env.VIM_GOPLS_MEMORY_MODE then
	gopls_options.memoryMode = vim.env.VIM_GOPLS_MEMORY_MODE
end

if not disabled_gopls then
	setup_lsp('gopls', {
		cmd = {'gopls', '-remote=auto'},
		init_options = gopls_options,
	})
end
