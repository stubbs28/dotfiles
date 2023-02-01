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
" Completion and snippets
Plug 'hrsh7th/cmp-buffer' " completion for buffer words
Plug 'hrsh7th/cmp-cmdline' " completion for vim's commandline
Plug 'hrsh7th/cmp-nvim-lsp' " completion for nvim-lsp
Plug 'hrsh7th/cmp-path' " completion for filesystem paths
Plug 'hrsh7th/nvim-cmp' " completion engine plugin
Plug 'honza/vim-snippets' " vim snippets
Plug 'quangnguyen30192/cmp-nvim-ultisnips' " cmp snippets
Plug 'SirVer/ultisnips' " snippet engine

" Filetype-specific
Plug 'direnv/direnv.vim' " integrate direnv and nvim
Plug 'fatih/vim-go' " golang development tools
Plug 'hynek/vim-python-pep8-indent' " python file format support
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " markdown file format support
Plug 'solarnz/thrift.vim', {'for': 'thrift'} " thrift file format support
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'} " requirements file format support

" Git
Plug 'mhinz/vim-signify' " git marks next to line numbers

" Look and feel
Plug 'Iron-E/nvim-soluarized' " solarized colorscheme
Plug 'nvim-lualine/lualine.nvim' " line at the bottom
Plug 'pgdouyon/vim-evanesco' " auto clear search highlighting
Plug 'nvim-tree/nvim-web-devicons' " Extra icons
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " AST-based syntax highlighting 
Plug 'weilbith/nvim-code-action-menu' " Nice code action menu
Plug 'kosayoda/nvim-lightbulb' " Lightbulb in gutter
Plug 'RRethy/vim-illuminate' " highlight similar words

" LSP and language features
Plug 'neovim/nvim-lspconfig' " Default LSP configuration
" Plug 'nvim-lua/lsp_extensions.nvim' " Additional LSP extension callbacks
Plug 'onsails/lspkind-nvim' " add pictograms to lsp
Plug 'tami5/lspsaga.nvim', {'branch': 'main'} " neovim LSP nicer UI
Plug 'ray-x/lsp_signature.nvim'

" Navigation and window management
Plug 'nvim-tree/nvim-tree.lua' " File tree
Plug 'rking/ag.vim' " silver-seracher in vim

call plug#end()

" Required:
filetype plugin indent on
