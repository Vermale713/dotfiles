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

require("paq")({
	-- Dependencies
	"savq/paq-nvim", -- Let Paq manage itself
	"neovim/nvim-lspconfig",
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	"rebelot/kanagawa.nvim",
	-- Packages
	{
		"akinsho/bufferline.nvim",
		version = "*",
	},
	"nvim-lualine/lualine.nvim",
	"lopi-py/luau-lsp.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"mason-org/mason.nvim",
	"mason-org/mason-lspconfig.nvim",
	"saghen/blink.cmp",
	"stevearc/conform.nvim",
	"numToStr/Comment.nvim",
	"m4xshen/autoclose.nvim",
	{ "nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
})
require("config.opts")
require("config.mapping")
require("config.theme")
