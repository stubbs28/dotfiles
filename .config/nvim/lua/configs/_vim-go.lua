-- LSP will run gopls.
vim.g.go_gopls_enabled = 0
-- LSP will provide go-to-def.
vim.g.go_def_mapping_enabled = 0
-- LSP will provide code completion.
vim.g.go_code_completion_enabled = 0
-- LSP will provide inline documentation.
vim.g.go_doc_keywordprg_enabled = 0
-- don't run "go vet" or "revive on save. LSP will lint.
vim.g.go_metalinter_autosave_enabled = {}
-- LSP to auto organize imports
vim.g.go_imports_autosave = 0
-- LSP to lint on save
vim.g.go_fmt_autosave = 0
vim.cmd([[
    augroup go
      autocmd!
      autocmd Filetype go
        \  command! -bang A call go#alternate#Switch(<bang>0, 'edit')
        \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
        \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    augroup END
]])
