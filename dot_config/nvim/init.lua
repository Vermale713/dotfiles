vim.treesitter.language.add("luau", {
	path = "C:/Users/Vermale/.config/nvim/parser/luau.dll",
})
vim.treesitter.language.register("luau", "luau")

vim.lsp.config("*", {
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	},
	root_markers = { ".git" },
})

require "config.keymap"
require "config.opts"
require "config.autocmd"
require("config.lockin").setup()
require("config.twitch").setup()
