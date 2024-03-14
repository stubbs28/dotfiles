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
