vim.treesitter.language.add("luau", {
	path = "C:/Users/Vermale/.config/nvim/parser/luau.dll",
})
vim.treesitter.language.register("luau", "luau")

require("config.keymap")
require("config.opts")
require("config.autocmd")
