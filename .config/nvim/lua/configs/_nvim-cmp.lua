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
	}
}

