vim.g.go_def_mapping_enabled = 0
vim.g.go_code_completion_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_metalinter_autosave_enabled = {}
vim.g.go_gopls_enabled = 0
vim.g.go_term_enabled = 1
vim.g.go_term_reuse = 1
vim.g.go_term_mode = "split"
if vim.env.VIM_GO_BIN_PATH then
	vim.g.go_bin_path = vim.env.VIM_GO_BIN_PATH
end
vim.cmd([[
    augroup go
      autocmd!
      autocmd Filetype go
        \  command! -bang A call go#alternate#Switch(<bang>0, 'edit')
        \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
        \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    augroup END
]])
