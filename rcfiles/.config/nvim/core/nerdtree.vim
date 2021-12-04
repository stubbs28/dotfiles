"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy open
map <leader>nt :NERDTreeToggle<cr>
" Open on startup
" autocmd VimEnter * NERDTree
" Move cursor to main window
autocmd VimEnter * wincmd p
" Set window size
"let g:NERDTreeWinSize = 20
" Show hidden files
let NERDTreeShowHidden = 1
" set NERDTree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
