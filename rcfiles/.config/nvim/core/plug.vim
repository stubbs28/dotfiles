"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Installation
"
" Sections:
"    -> Bootstrap
"    -> Install
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bootstrap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Install
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'pgdouyon/vim-evanesco'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'jelera/vim-javascript-syntax'
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'rust-lang/rust.vim'

call plug#end()

" Required:
filetype plugin indent on
