vim.opt.compatible  = false -- no backwards compatibility with vi
vim.opt.backup      = false -- don't backup edited files
vim.opt.writebackup = true -- but temporarily backup before overwiting
vim.opt.backspace   = {    -- sane backspace handling
  'indent',
  'eol',
  'start'
}
vim.opt.colorcolumn = '80'   -- Highlight column 80
vim.opt.ruler       = true -- show the cursor position
vim.opt.laststatus  = 2    -- always show status line
vim.opt.showcmd     = true -- display incomplete commands
vim.opt.hidden      = true -- allow buffers to be hidden without saving
vim.opt.history     = 50 -- history of : commands
vim.opt.wildmenu    = true -- show options for : completion
vim.opt.number      = true -- show line number of the current line and
vim.opt.expandtab   = false
vim.opt.softtabstop = 0
vim.opt.shiftwidth  = 8 -- Use 8 tabs for indentation.
vim.opt.tabstop     = 8
vim.opt.textwidth   = 79    -- default to narrow text
vim.opt.virtualedit = 'all' -- use virtual spaces
vim.opt.scrolloff   = 5     -- lines below cursor when scrolling
vim.opt.copyindent     = true -- Preserve existing indentation as much as possible.
vim.opt.preserveindent = true
vim.opt.autoindent     = true
vim.opt.incsearch = true -- show search results incrementally
vim.opt.wrap      = false -- don't wrap long lines
vim.opt.joinspaces = false -- Don't add two spaces after a punctuation when joining lines with J.
vim.opt.ignorecase = true        -- ignore caing during search
vim.opt.smartcase  = true        -- except if uppercase characters were used
vim.opt.tagcase    = 'followscs' -- and use the same for tag searches
vim.opt.inccommand = 'split' -- show :s results incrementally
vim.opt.hlsearch = true -- highlight search results
vim.opt.lazyredraw = true  -- don't redraw while running macros
vim.opt.visualbell = true -- don't beep
vim.opt.mouse = 'a' -- support mouse
vim.opt.background = 'dark'
vim.opt.splitbelow = true -- New splits should go below or to the right of the current window.
vim.opt.splitright = true
vim.opt.foldmethod = 'marker' -- don't fold unless there are markers
vim.opt.list = true -- Show tabs and trailing spaces.
vim.opt.listchars = {
  tab = '▸ ',
  extends = '❯',
  precedes = '❮'
}
vim.opt.fillchars = {
  vert = '|'
}
vim.opt.wildignore = { -- Patterns to ignore in wildcard expansions.
  '*/cabal-dev',
  '*/dist',
  '*.o',
  '*.class',
  '*.pyc',
  '*.hi',
}
vim.opt.completeopt = {
  'noinsert',
  'menuone',
  'noselect',
  'preview'
}
-- Use true colors if we're not on Apple Terminal.
if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
	vim.opt.termguicolors = true
end

vim.g.mapleader = ',' -- use comma as leader
vim.g.loaded_netrw = 1 -- disable netrw
vim.g.loaded_netrwPlugin = 1

vim.cmd('colorscheme solarized')
