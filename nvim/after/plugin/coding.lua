local ignore_globs = {
	"**/_Index/**",
	"**/.pesde/**",
	"node_modules/**",
	"build/**",
}

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
})
return {
	settings = {
		["luau-lsp"] = {
			ignoreGlobs = ignore_globs,
			completion = {
				imports = {
					enabled = true,
					ignoreGlobs = ignore_globs,
				},
				fillCallArguments = false,
			},
			inlayHints = {
				functionReturnTypes = true,
				parameterTypes = true,
			},
		},
	},
}
