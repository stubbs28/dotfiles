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
			require('snippy').expand_snippet(args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	sources = cmp.config.sources({
		{name = 'nvim_lsp'},
		{name = 'snippy'},
		{name = 'buffer'},
		{name = 'path'},
		{name = 'tmux'},
	}),
	experimental = {
		ghost_text = {
			hl_group = "LspCodeLens",
		},
	},
}
