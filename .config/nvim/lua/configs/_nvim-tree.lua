local function nvim_tree_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end
require('nvim-tree').setup({
   on_attach = nvim_tree_attach,
   diagnostics = {
    enable = true,
  },
  git = {
    ignore = false,
  }
})
vim.keymap.set('n', '<leader>nt', ':NvimTreeToggle<CR>', {})
