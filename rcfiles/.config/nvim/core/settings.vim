colorscheme soluarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual Mode Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving Around, Tabs, Windows and Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
" Close all the buffers
map <leader>ba :bufdo bd<cr>
" Map buffer navigation shortcuts
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
" Quickfix jump shortcuts
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
map <leader>a :cclose<CR>
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show special characters when tabs are used
"if has("unix")
"    set list
"    set listchars=tab:▸\ ,extends:❯,precedes:❮
"    set fillchars+=vert:│
"endif
" Remap VIM 0 to first non-blank character
map 0 ^
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NvimTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Easy open
map <leader>nt :NvimTreeToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Golang
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :GoAlternate shortcuts
autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd FileType go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd FileType go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
