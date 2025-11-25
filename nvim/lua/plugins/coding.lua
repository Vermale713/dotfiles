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

return {
	-- Lsp
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		-- config = true,
		config = function()
			require("flutter-tools").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"L3MON4D3/LuaSnip",
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	-- Stuff the mason-lspconfig can't install
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				-- Linter & Formatter

				-- Lua/Luau
				"selene", -- Lua Linter
				"stylua", -- Lua Formatter
				-- JS/TS
				"prettierd", -- Typescript Formatter
				"prettier", -- Typescript Formatter
				-- Python
				"ruff", -- Python Linter
				"black", -- Python Formatter
				-- Yaml
				"yamlfmt",
				-- Github Actions
				"actionlint", -- Github Action Linter
				-- Go
				"goimports", -- Go

				-- LSP's

				"lua_ls", -- General Lua
				"luau_lsp", -- Roblox

				"ts_ls", -- Typescript

				"cssls", -- CSS
				"css_variables", -- CSS

				"gopls", -- Go

				"jsonls", -- Json

				"pylsp", -- Python

				"yamlls", -- Yaml
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 3000,
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = "VeryLazy",
		opts = {
			automatic_installation = false,
			automatic_enable = {
				exclude = { "luau_lsp" },
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"lopi-py/luau-lsp.nvim",
		opts = {
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
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- Autocomplete
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
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
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = true } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	-- Format
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				-- Lua/Luau
				lua = { "stylua" },
				luau = { "stylua" },
				-- Javascript/Typescript
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				-- Python
				python = { "black" },
				-- Yaml
				yaml = { "yamlfmt" },
				yml = { "yamlfmt" },
				-- Go
				go = { "goimports" },
			},
			format_on_save = {
				timeout_ms = 60000,
				lsp_format = "fallback",
			},
			format_after_save = {
				lsp_format = "fallback",
			},
		},
	},
	-- Comment
	{
		"numToStr/Comment.nvim",
		opts = {
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
		},
	},
	-- Autoclose
	{
		"m4xshen/autoclose.nvim",
		opts = {
			options = {
				disabled_filetypes = { "text" },
			},
		},
	},
}
