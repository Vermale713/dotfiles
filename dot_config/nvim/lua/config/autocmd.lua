vim.api.nvim_create_autocmd("FileType", {
	pattern = "luau",
	callback = function(args)
		vim.bo[args.buf].commentstring = "-- %s"
		vim.treesitter.start(args.buf, "luau")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "zig",
	callback = function(args)
		vim.bo[args.buf].commentstring = "// %s"
	end,
})
