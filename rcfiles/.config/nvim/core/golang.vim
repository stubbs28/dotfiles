"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Golang
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup golang
	" :GoRun shortcut
	autocmd FileType go nmap <leader>r <Plug>(go-run)
	" :GoTest shortcut
	autocmd FileType go nmap <leader>t <Plug>(go-test)
	autocmd FileType go nmap <leader>tf <Plug>(go-test-func)
	" :GoCoverageToggle shortcut
	autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
	" :GoAlternate shortcuts
	autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
	autocmd FileType go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
	autocmd FileType go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
	autocmd FileType go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END
" Make all lists quickfix
let g:go_list_type = "quickfix"
" Run :GoImport on save
let g:go_fmt_command = "goimports"
" Run :GoMetaLinter on save
let g:go_metalinter_autosave = 1
" Set test timeout
let g:go_test_timeout = '20s'
" More syntax highlighting
"let g:go_highlight_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_function_calls = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_extra_types = 1
"let g:go_highlight_build_constraints = 1
" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
augroup golang
	autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
augroup END

