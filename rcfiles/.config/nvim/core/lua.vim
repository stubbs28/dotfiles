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
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gh', '<Cmd>lua require"lspsaga.provider".lsp_finder()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local rust_tool_opts = {
    tools = {
      autoSetHints = true,
      hover_with_actions = true,
      runnables = {
        use_telescope = true,
      },
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = " ",
            other_hints_prefix  = " ",
        },
    },
    server = {on_attach = on_attach}, -- rust-analyzer options
}
require('rust-tools').setup(rust_tool_opts)

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
