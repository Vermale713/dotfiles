-- INSTALL PLUGINS
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/lopi-py/luau-lsp.nvim" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

-- SETUP PLUGINS
local cmp = require("blink.cmp")

cmp.build():pwait()
cmp.setup({
	keymap = {
		["<C-s>"] = { "show", "fallback" },
		["<Tab>"] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.accept()
				else
					return cmp.select_and_accept()
				end
			end,
			"snippet_forward",
			"fallback",
		},
		["<C-d>"] = { "show_documentation" },
	},

	cmdline = {
		keymap = {
			preset = "super-tab",
		},
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		documentation = { auto_show = false },
		keyword = { range = "full" },
		trigger = {
			show_in_snippet = false,
		},
		menu = {
			auto_show = true,
			auto_show_delay_ms = 0,
		},
	},
	sources = { default = { "lsp", "path", "snippets", "buffer" } },

	fuzzy = { implementation = "rust" },
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		luau = { "stylua" },
		rust = { "rustfmt", lsp_format = "fallback" },
		zig = { "zig", "zigfmt" },
	},
})
vim.keymap.set("n", "<leader>fa", function()
	require("conform").format({})
end)

require("luau-lsp").setup({
	fflags = {
		enable_new_solver = true, -- enables the fflags required for luau's new type solver
		sync = true, -- sync currently enabled fflags with roblox's published fflags
	},
	ft = "luau",
	types = {
		roblox_security_level = "PluginSecurity",
	},
	-- completion = {
	-- 	enabled = true,
	-- 	autocompleteEnd = true,
	-- 	imports = {
	-- 		enabled = true,
	-- 		useConst = true,
	-- 		suggestServices = true,
	-- 		suggestRequires = true,
	-- 		-- requireStyle = "auto",
	-- 		requireStyle = "alwaysRelative",
	-- 		-- requireStyle = "alwaysAbsolute",
	--            stringRequires = true,
	--            -- stringRequires = false,
	-- 		separateGroupsWithLine = true,
	-- 		ignoreGlobs = {
	-- 			"**/_Index/**",
	-- 			"**/.pesde/**",
	-- 		},
	-- 	},
	-- },
	sourcemap = {
		-- based on https://argon.wiki/docs/commands/cli#sourcemap
		enabled = true,
		generator_cmd = { "argon", "sourcemap", "--output", "sourcemap.json", "--watch", "--non-scripts" },
	},
	plugin = {
		enabled = true,
		port = 3667,
	},
})

require("mason").setup({})
require("mason-lspconfig").setup({
	automatic_enable = {
		exclude = { "luau_lsp" },
	},
})
