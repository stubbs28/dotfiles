"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rust
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rustfmt_autosave = 1
autocmd FileType rust nnoremap <leader>r :Cargo run<cr>
autocmd FileType rust nnoremap <leader>t :Cargo test<cr>
autocmd FileType rust nnoremap <leader>b :Cargo build<cr>
