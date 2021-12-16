lua << EOF

-- Lualine
require'lualine'.setup{
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
}

-- nvim-tree
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
   diagnostics = {
    enable = true,
  },
  view = {
    mappings = {
      list = {
        { key = "<C-s>", cb = tree_cb("system_open") },
        { key = "s", cb = tree_cb("split") },
        { key = "v", cb = tree_cb("vsplit") },
      }
    }
  }
}

-- LSP
local nvim_lsp = require('lspconfig')
require'lspsaga'.setup{}

require'lspkind'.init({
  with_text = false,
})
vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = true,
    float = {
        show_header = false,
        source = 'if_many',
        border = 'rounded',
        focusable = false,
    },
    update_in_insert = false, -- default to false
    severity_sort = false, -- default to false
})

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",  -- All maintained languages
  highlight = {
    enable = true
  },
}


EOF
