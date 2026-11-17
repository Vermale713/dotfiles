return {
	filetypes = { "luau" },
	root_markers = { ".luaurc" },
	settings = {
		["luau-lsp"] = {
			ignoreGlobs = {
				"**/_Index/**",
				"**/.pesde/**",
				"**/.lpm/**",
				"**/.ember/**",
				"**/dist/**",
			},
			fflags = {
				enableNewSolver = true, -- enables the fflags required for luau's new type solver
				sync = true, -- sync currently enabled fflags with roblox's published fflags
			},
			types = {
				robloxSecurityLevel = "PluginSecurity",
			},
			completion = {
				enabled = true,
				autocompleteEnd = true,
				imports = {
					enabled = true,
					useConst = true,
					suggestServices = true,
					suggestRequires = true,
					requireStyle = "alwaysAbsolute",
					-- requireStyle = "alwaysRelative",
					stringRequires = {
						enabled = true,
					},
					separateGroupsWithLine = true,
					ignoreGlobs = {
						"**/_Index/**",
						"**/.pesde/**",
						"**/.lpm/**",
						"**/.ember/**",
						"**/dist/**",
					},
				},
			},
			sourcemap = {
				enabled = true,
				-- the sourcemap is generated outside neovim; do not spawn a generator
				autogenerate = false,
				-- just dev runs scripts/sourcemap-editor.sh: the same Rojo sourcemap
				-- but pointing at src/ instead of dist/, so the files you edit are
				-- sourcemap-covered and auto-imports compute @game/... paths
				sourcemapFile = "sourcemap.editor.json",
			},
			plugin = {
				enabled = true,
				port = 3667,
			},
		},
	},
}
