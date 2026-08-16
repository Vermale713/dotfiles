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
require "config.cmds"
require("config.lockin").setup()
require("config.twitch").setup()

vim.bo.syntax = "on"
