"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rust
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rustfmt_autosave = 1
augroup rust
	autocmd!
	autocmd FileType rust nnoremap <leader>r :make run <cr>
	autocmd FileType rust nnoremap <leader>t :silent make test  <cr>
	autocmd FileType rust nnoremap <leader>b :silent make build <cr>
	autocmd QuickFixCmdPost [^1]* cwindow
	autocmd QuickFixCmdPost 1* lwindow
	autocmd VimEnter * cwindow
augroup END
