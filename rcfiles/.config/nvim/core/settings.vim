"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"
" Sections:
"    -> General
"    -> VIM User Interface
"    -> Colors and Fonts
"    -> Files, Backups and Undo
"    -> Text, Tab and Indent Related
"    -> Visual Mode Related
"    -> Moving Around, Tabs, Windows and Buffers
"    -> Editing Mappings
"    -> Misc
"    -> Helper functions
"    -> NvimTree
"    -> Golang
"    -> Rust
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500
" Set to auto read and write
set autoread
set autowrite
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable mouse
set mouse=a
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" Turn on the Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
" No folding
set nofoldenable
" Always show current position
set ruler
" Enable line numbers
set number
" A buffer becomes hidden when it is abandoned
set hid
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 
" Don't redraw while executing macros (good performance config)
set lazyredraw 
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 
" Highlight column 80
set colorcolumn=80
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Enable 24-bit colors
set termguicolors
" set colorscheme
set bg=dark
colorscheme soluarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, Backups and Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, Tab and Indent Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Linebreak on 500 characters
set lbr
set tw=500
" indent settings
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" yaml tab width
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" json tab width
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
" javascript tab width
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab


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
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
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
if has("unix")
  set list
  set listchars=tab:▸\ ,extends:❯,precedes:❮
  set fillchars+=vert:│
endif
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
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")
    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif
    if bufnr("%") == l:currentBufNum
        new
    endif
    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NvimTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Easy open
map <leader>nt :NvimTreeToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Golang
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Make all lists quickfix
let g:go_list_type = "quickfix"
" Run :GoImport on save
let g:go_fmt_command = "goimports"
" Run :GoMetaLinter on save
let g:go_metalinter_autosave = 1
" Set test timeout
let g:go_test_timeout = '20s'
" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>


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
