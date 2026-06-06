local custom_parsers = {
	luau = "luau",
}

for ft, lang in pairs(custom_parsers) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = ft,
		callback = function(ev)
			local ok, err = pcall(vim.treesitter.start, ev.buf, lang)
			if not ok then
				vim.notify(
					"treesitter: failed to start parser '" .. lang .. "' for ft '" .. ft .. "': " .. err,
					vim.log.levels.WARN
				)
			end
		end,
	})
end
