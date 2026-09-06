-- `larvae self install` puts the server in ~/.larvae/bin, which is not on PATH.
-- Prefer PATH so a later install elsewhere still wins; fall back to that directory.
local cmd = vim.fn.executable "larvae-lsp" == 1 and "larvae-lsp" or vim.fn.expand "~/.larvae/bin/larvae-lsp"

return {
	cmd = { cmd },
	filetypes = { "luau" },
	root_markers = { "larvae.toml", ".luaurc", "ember.toml", ".git" },
}
