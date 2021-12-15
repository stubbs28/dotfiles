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
Plug 'scrooloose/nerdtree' " tree explorer
Plug 'vim-airline/vim-airline' " status/tab lines
Plug 'vim-airline/vim-airline-themes' " themes for status/tab lines
Plug 'altercation/vim-colors-solarized' " solarized color scheme
Plug 'rking/ag.vim' " silver-seracher in vim
Plug 'pgdouyon/vim-evanesco' " auto clear search highlighting
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'} " requirements file format support
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'} " golang development tools
Plug 'davidhalter/jedi-vim' " python development tools
Plug 'rust-lang/rust.vim' " rust development tools

call plug#end()

" Required:
filetype plugin indent on
