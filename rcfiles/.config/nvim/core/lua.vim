lua << EOF
-------------------------------------------------------------------------------
-- => General
-------------------------------------------------------------------------------
-- vim.lsp.set_log_level("debug")

if vim.env.VIM_PATH then
	vim.env.PATH = vim.env.VIM_PATH
end

local options = {
	compatible = false, -- no backwards compatibility with vi

	backup      = false, -- don't backup edited files
	writebackup = true, -- but temporarily backup before overwiting

	backspace = {'indent', 'eol', 'start'}, -- sane backspace handling

	colorcolumn = '80',   -- Highlight column 80
	ruler       = true, -- show the cursor position
	laststatus  = 2,    -- always show status line
	showcmd     = true, -- display incomplete commands
	hidden      = true, -- allow buffers to be hidden without saving

	history    = 50, -- history of : commands
	wildmenu = true, -- show options for : completion

	number         = true, -- show line number of the current line and

	-- Use 8 tabs for indentation.
	expandtab   = false,
	softtabstop = 0,
	shiftwidth  = 8,
	tabstop     = 8,

	textwidth   = 79,    -- default to narrow text
	virtualedit = 'all', -- use virtual spaces
	scrolloff   = 5,     -- lines below cursor when scrolling

	-- Preserve existing indentation as much as possible.
	copyindent     = true,
	preserveindent = true,
	autoindent     = true,

	incsearch = true, -- show search results incrementally
	wrap      = false, -- don't wrap long lines

	-- Don't add two spaces after a punctuation when joining lines with J.
	joinspaces = false,

	ignorecase = true,        -- ignore caing during search
	smartcase  = true,        -- except if uppercase characters were used
	tagcase    = 'followscs', -- and use the same for tag searches

	inccommand = 'split', -- show :s results incrementally
	hlsearch = true, -- highlight search results

	lazyredraw = true,  -- don't redraw while running macros
	visualbell = true, -- don't beep
	mouse = 'a', -- support mouse

	background = 'dark',

	-- New splits should go below or to the right of the current window.
	splitbelow = true,
	splitright = true,

	foldmethod = 'marker', -- don't fold unless there are markers

	-- Show tabs and trailing spaces.
	list = true,
	listchars = {tab = '▸ ', extends = '❯', precedes = '❮'},
	fillchars = {vert = '|'},


	-- Patterns to ignore in wildcard expansions.
	wildignore = {
		'*/cabal-dev', '*/dist', '*.o', '*.class', '*.pyc', '*.hi',
	},

	completeopt = {'noinsert', 'menuone', 'noselect', 'preview'},
}
for name, val in pairs(options) do
	vim.opt[name] = val
end

-- Use true colors if we're not on Apple Terminal.
if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
	vim.opt.termguicolors = true
end

-- let_g(table)
-- let_g(prefix, table)
--
-- Sets values on g:*. If prefix is non-empty, it's added to every key.
function let_g(prefix, opts)
	if opts == nil then
		opts, prefix = prefix, ''
	end

	for key, val in pairs(opts) do
		if prefix ~= '' then
			key = prefix .. key
		end
		vim.g[key] = val
	end
end

let_g {
	mapleader = ',', -- use comma as leader
	loaded_netrw = 1, -- disable netrw
	loaded_netrwPlugin = 1,
}
-------------------------------------------------------------------------------
-- => NeoSolarized
-------------------------------------------------------------------------------
-- require('NeoSolarized').setup({
--   style = "dark",
--   transparent = false,
-- })
-- 
-- vim.cmd [[ colorscheme NeoSolarized ]]
-- 
-------------------------------------------------------------------------------
-- => solarized
-------------------------------------------------------------------------------
vim.cmd('colorscheme solarized')
-------------------------------------------------------------------------------
-- => lualine
-------------------------------------------------------------------------------
require('lualine').setup({
  options = {
    theme = 'solarized'
  },
  sections = {
    lualine_b = { 'branch', { 'diff', colored = false }, 'diagnostics'},
	lualine_c = { { 'filename', path=1 } },
    lualine_x = {'encoding'},
    lualine_z = {'%3l/%L:%3c'}
  },
  tabline = {
	  lualine_a = {'buffers'},
  },
  extensions = {
    'fzf', 'quickfix', 'fugitive', 'nvim-tree'
  }
})


-------------------------------------------------------------------------------
-- => nvim-treesitter
-------------------------------------------------------------------------------
require('nvim-treesitter').setup({
  ensure_installed = {"lua", "vim", "go", "python", "markdown"},
})

-------------------------------------------------------------------------------
-- => nvim-tree
-------------------------------------------------------------------------------
require('nvim-tree').setup({
   diagnostics = {
    enable = true,
  },
  git = {
    ignore = false,
  }
})

-------------------------------------------------------------------------------
-- => nvim-cmp
-------------------------------------------------------------------------------
local cmp = require('cmp')

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local handleTab = function(fallback)
	if cmp.visible() then
		if cmp.get_selected_entry() ~= nil then
			cmp.confirm()
		else
			cmp.select_next_item()
		end
	elseif vim.fn['UltiSnips#CanJumpForwards']() == 1 then
		feedkey("<Plug>(ultisnips_jump_forward)", "")
	else
		fallback()
	end
end

cmp.setup {
	completion = {
		keyword_length = 3,
	},
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		-- Ctrl-u/d: scroll docs of completion item if available.
		['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

		-- tab: If completion menu is visible and nothing has been selected,
		-- select first item. If something is selected, start completion with that.
		-- If in the middle of the completion, jump to next snippet position.

		-- Tab/Shift-Tab:
		-- If completion menu is not visible,
		--  1. if we're in the middle of a snippet, move forwards/backwards
		--  2. Otherwise use regular key behavior
		--
		-- If completion menu is visible and,
		--  1. no item is selected, select the first/last one
		--  2. an item is selected, start completion with it
		['<Tab>'] = cmp.mapping({
			i = handleTab,
			s = handleTab,
		}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
				feedkey("<Plug>(ultisnips_jump_backward)", "")
			else
				fallback()
			end
		end, {'i', 's'}),

		-- Ctrl-Space: force completion
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

		-- Ctr-e: cancel completion
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),

		-- Enter: confirm completion
		['<CR>'] = cmp.mapping.confirm({select = false}),
	},
	sources = cmp.config.sources({
		{name = 'nvim_lsp'},
		{name = 'ultisnips'},
	}, {
		{name = 'path'},
		{name = 'buffer'},
		{name = 'tmux'},
	}),
	experimental = {
		ghost_text  = true,
	},
}

-------------------------------------------------------------------------------
-- => UltiSnips
-------------------------------------------------------------------------------
vim.api.nvim_set_keymap('i', '<c-u>', '<Plug>(ultisnips_expand)', {})
let_g('UltiSnips', {
	ExpandTrigger            = "<Plug>(ultisnips_expand)",
	JumpForwardTrigger       = "<Plug>(ultisnips_jump_forward)",
	JumpBackwardTrigger      = "<Plug>(ultisnips_jump_backward)",
	ListSnippets             = "<c-x><c-s>",
	RemoveSelectModeMappings = 0,
})


-------------------------------------------------------------------------------
-- => lspconfig
-------------------------------------------------------------------------------
local nvim_lsp = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_signature = require('lsp_signature')

function setup_lsp(server, lsp_opts)
	lsp_opts.on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		-- Show hints for every parameter, but don't need to report the
		-- signature again since it's easily accessible.
		-- lsp_signature.on_attach({
		-- 	bind = true,
		-- 	floating_window = false,
		-- 	hint_enable = true,
		-- 	always_trigger = true,
		-- }, bufnr)

		buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
		local opts = { noremap = true, silent = true}

		-- Keybindings
		--  K            Documentation
		--  <leader>d    Go to definition
		--  F2           Rename
		--  Alt-Enter    Code action

		buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
		buf_set_keymap('n', '<F1>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		buf_set_keymap('n', '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	end

	lsp_opts.capabilities = lsp_capabilities
	lsp_opts.flags = {
		-- Don't spam LSP with changes. Wait a second between updates.
		debounce_text_changes = 1000,
	}

	nvim_lsp[server].setup(lsp_opts)
end

-- LSP implementations that don't need any configuration.
local default_lsps = {
	'clojure_lsp',
	'hie',
	'pylsp',
	'zls',
}

for _, server in pairs(default_lsps) do
	setup_lsp(server, {})
end

-------------------------------------------------------------------------------
-- => markdown-preview
-------------------------------------------------------------------------------
let_g('mkdp_', {
	auto_close = 0,
	filetypes = {'markdown', 'vimwiki'},
})


-------------------------------------------------------------------------------
-- => go
-------------------------------------------------------------------------------
-- vim-go {
let_g('go_', {
	def_mapping_enabled = 0,
	code_completion_enabled = 0,
	doc_keywordprg_enabled = 0,
	metalinter_autosave_enabled = {},
	gopls_enabled = 0,
	term_enabled = 1,
	term_reuse = 1,
	term_mode = "split",
	template_file = vim.env.HOME .. "/.config/vim-go/main.go",
	template_test_file = vim.env.HOME .. "/.config/vim-go/test.go",
})

if vim.env.VIM_GO_BIN_PATH then
	vim.g.go_bin_path = vim.env.VIM_GO_BIN_PATH
end

-- go lsp {
-- Support disabling gopls and LSP by setting an environment variable,
-- and in diff mode.
local disable_gopls = vim.env.VIM_GOPLS_DISABLED or vim.opt.diff:get()

local gopls_options = {
	gofumpt         = true,
	staticcheck     = true,
	usePlaceholders = true,
}

-- Support overriding memory mode with an environment variable.
if vim.env.VIM_GOPLS_MEMORY_MODE then
	gopls_options.memoryMode = vim.env.VIM_GOPLS_MEMORY_MODE
end

if not disabled_gopls then
	setup_lsp('gopls', {
		cmd = {'gopls', '-remote=auto'},
		init_options = gopls_options,
	})
end

EOF
