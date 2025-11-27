local ignore_globs = {
	"**/_Index/**",
	"**/.pesde/**",
	"node_modules/**",
	"build/**",
}
local rojo_project = vim.fs.root(0, function(name)
	return name:match(".+%.project%.json$")
end)

if rojo_project then
	vim.filetype.add({
		extension = {
			lua = function(path)
				return path:match("%.nvim%.lua$") and "lua" or "luau"
			end,
		},
	})
end

require("luau-lsp").setup({
	fflags = {
		enable_new_solver = true,
		sync = true,
	},
	ft = "luau",
	platform = { type = rojo_project and "roblox" or "standard" },
	types = {
		roblox_security_level = "PluginSecurity",
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
})

vim.lsp.config("luau-lsp", {
	settings = {
		["luau-lsp"] = {
			ignoreGlobs = ignore_globs,
			globals = {},
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
})
require("mason").setup({
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
})
require("mason-tool-installer").setup({
	ensure_installed = {
		-- Linter & Formatter

		-- Lua/Luau
		"selene", -- Lua Linter
		"stylua", -- Lua Formatter
		-- JS/TS
		"prettierd", -- Typescript Formatter
		"prettier", -- Typescript Formatter
		-- Yaml
		"yamlfmt",
		-- Github Actions
		"actionlint", -- Github Action Linter

		-- LSP's
		"luau_lsp", -- Roblox

		"ts_ls", -- Typescript

		"cssls", -- CSS
		"css_variables", -- CSS

		"jsonls", -- Json
		"yamlls", -- Yaml
	},
	auto_update = false,
	run_on_start = true,
	start_delay = 3000,
})
require("mason-lspconfig").setup({
	automatic_installation = false,
	automatic_enable = {
		exclude = { "luau_lsp" },
	},
})
require("blink.cmp").setup({
	version = "1.*",
	build = "cargo build --release",
	keymap = {
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
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
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "lua" },
	opts_extend = { "sources.default" },
})
require("conform").setup({
	formatters_by_ft = {
		-- Lua/Luau
		lua = { "stylua" },
		luau = { "stylua" },
		-- Javascript/Typescript
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		-- Yaml
		yaml = { "yamlfmt" },
		yml = { "yamlfmt" },
	},
	format_on_save = {
		timeout_ms = 60000,
		lsp_format = "fallback",
	},
	format_after_save = {
		lsp_format = "fallback",
	},
})
require("Comment").setup({
	toggler = {
		line = "q",
		block = "cb",
	},
	opleader = {
		line = "q",
		block = "cb",
	},

	mapping = {
		basic = true,
		extra = false,
	},
})
require("autoclose").setup({
	options = {
		disabled_filetypes = { "text" },
	},
})
