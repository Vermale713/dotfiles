-- `larvae self install` puts the server in ~/.larvae/bin, which is not on PATH.
-- Prefer PATH so a later install elsewhere still wins; fall back to that directory.
local cmd = vim.fn.executable "larvae-lsp" == 1 and "larvae-lsp" or vim.fn.expand "~/.larvae/bin/larvae-lsp"

-- larvae-lsp runs `rojo sourcemap --watch` itself whenever it finds a rojo project
-- file. That is read only from the project's larvae.toml -- it ignores
-- initializationOptions and has no CLI flag or env var -- so per project:
--   [lsp]
--   sourcemap_autogenerate = false
return {
	cmd = { cmd },
	filetypes = { "luau" },
	root_markers = { "larvae.toml", ".luaurc", "ember.toml", ".git" },
}
