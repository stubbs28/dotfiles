local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- Completion and snippets
Plug 'hrsh7th/cmp-buffer'			-- completion for buffer words
Plug 'hrsh7th/cmp-cmdline'			-- completion for vim's commandline
Plug 'hrsh7th/cmp-nvim-lsp'			-- completion for nvim-lsp
Plug 'hrsh7th/cmp-path'				-- completion for filesystem paths
Plug 'hrsh7th/nvim-cmp'				-- completion engine plugin
Plug 'cappyzawa/trim.nvim'			-- clean up trailing whitespace
Plug 'honza/vim-snippets' 			-- vim snippets
Plug 'quangnguyen30192/cmp-nvim-ultisnips'	-- cmp snippets
Plug 'SirVer/ultisnips' 			-- snippet engine

-- Filetype-specific
Plug 'sheerun/vim-polyglot'			-- collection of language packs
Plug 'fatih/vim-go' 				-- golang development tools
Plug 'hynek/vim-python-pep8-indent'		-- python file format support
Plug('iamcco/markdown-preview.nvim', {		-- markdown file format support
	['do'] = vim.fn['mkdp#util#install'],
	['for'] = {'markdown', 'vim-plug'}
})
Plug('solarnz/thrift.vim', { 			-- thrift file format support
	['for'] = 'thrift' 
})
Plug('raimon49/requirements.txt.vim', {		-- requirements file format support
	['for'] = 'requirements'
})

-- Git
Plug 'mhinz/vim-signify' 			-- git marks next to line numbers

-- Look and feel
Plug 'ishan9299/nvim-solarized-lua'		-- Solarized theme
Plug 'nvim-lualine/lualine.nvim' 		-- line at the bottom
Plug 'pgdouyon/vim-evanesco' 			-- auto clear search highlighting
Plug 'nvim-tree/nvim-web-devicons' 		-- Extra icons
Plug('nvim-treesitter/nvim-treesitter', {	-- AST-based syntax highlighting 
  ['do'] = function()
    vim.cmd("TSUpdate")
  end
})
Plug 'weilbith/nvim-code-action-menu'		-- Nice code action menu
Plug 'kosayoda/nvim-lightbulb'			-- Lightbulb in gutter
Plug 'RRethy/vim-illuminate'			-- highlight similar words
Plug 'kazhala/close-buffers.nvim'		-- easily close buffers
Plug 'vladdoster/remember.nvim'			-- open last

-- LSP and language features
Plug 'neovim/nvim-lspconfig'			-- Default LSP configuration
Plug 'onsails/lspkind-nvim'			-- add pictograms to lsp
Plug 'nvimdev/lspsaga.nvim'			-- neovim LSP nicer UI
Plug 'ray-x/lsp_signature.nvim'

-- Navigation and window management
Plug 'nvim-tree/nvim-tree.lua'			-- File tree
Plug 'rking/ag.vim'				-- silver-seracher in vim

vim.call('plug#end')
