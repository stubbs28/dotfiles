vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function(args)
		goFormatAndImports(60000)
	end,
})
