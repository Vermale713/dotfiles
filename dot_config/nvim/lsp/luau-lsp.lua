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
			},
			fflags = {
				enable_new_solver = true, -- enables the fflags required for luau's new type solver
				sync = true, -- sync currently enabled fflags with roblox's published fflags
			},
			ft = "luau",
			types = {
				roblox_security_level = "PluginSecurity",
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
					},
				},
			},
			sourcemap = {
				-- based on https://argon.wiki/docs/commands/cli#sourcemap
				enabled = true,
				generator_cmd = { "argon", "sourcemap", "--output", "sourcemap.json", "--watch", "--non-scripts" },
			},
			plugin = {
				enabled = true,
				port = 3667,
			},
		},
	},
}
