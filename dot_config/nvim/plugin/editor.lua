-- INSTALL PLUGINS
vim.pack.add {
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/navarasu/onedark.nvim" },
	{ src = "https://github.com/dchinmay2/alabaster.nvim" },
	{ src = "https://github.com/zootedb0t/citruszest.nvim" },
	{ src = "https://github.com/kvrohit/rasmus.nvim" },
	{ src = "https://github.com/saghen/blink.indent" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/shortcuts/no-neck-pain.nvim" },
	-- TODO: replace plenary sometime
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
}

-- SETUP PLUGINS
vim.fn.mkdir(vim.fn.stdpath "data" .. "/notes", "p")
require("no-neck-pain").setup {
	width = 100,
	buffers = {
		scratchPad = {
			enabled = true,
			pathToFile = vim.fn.stdpath "data" .. "/notes/scratchpad.norg",
		},
	},
}
require("no-neck-pain").setup {
	width = 100,
	buffers = {
		scratchPad = {
			enabled = true,
			pathToFile = vim.fn.stdpath "data" .. "/notes/scratchpad.norg", -- pick your path
		},
	},
}

require("onedark").setup {
	style = "deep",
}

require("Comment").setup {
	toggler = {
		---Line-comment toggle keymap
		line = "q",
	},
	---LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		line = "q",
	},
	---LHS of extra mappings
	extra = {
		above = "gcO",
		---Add comment on the line below
		below = "gco",
		---Add comment at the end of line
		eol = "gcA",
	},
}

vim.api.nvim_set_keymap("n", "<leader>z", "<cmd>NoNeckPain<cr>", { silent = true, noremap = true })

local comment_ft = require "Comment.ft"

comment_ft.set("zig", "//%s")

local t_builtin = require "telescope.builtin"
-- File Picker
vim.keymap.set("n", "<leader><leader>", t_builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>lg", t_builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", t_builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>ht", t_builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>ff", function()
	t_builtin.find_files { hidden = true }
end, { desc = "Telescope find all files" })
-- Git
vim.keymap.set("n", "<leader>gc", t_builtin.git_commits, { desc = "Telescope git commits" })
vim.keymap.set("n", "<leader>gf", t_builtin.git_files, { desc = "Telescope git files" })
vim.keymap.set("n", "<leader>gb", t_builtin.git_branches, { desc = "Telescope git branches" })
vim.keymap.set("n", "<leader>gs", t_builtin.git_status, { desc = "Telescope git status" })
vim.keymap.set("n", "<leader>gl", "<Cmd>LazyGit<Cr>", { desc = "Telescope git status" })
-- Lsp
vim.keymap.set("n", "<leader>sd", t_builtin.diagnostics, { desc = "Telescope open diagnostics" })
vim.keymap.set("n", "<leader>gf", t_builtin.git_files, { desc = "Telescope git files" })
vim.keymap.set("n", "<leader>gb", t_builtin.git_branches, { desc = "Telescope git branches" })
vim.keymap.set("n", "<leader>gs", t_builtin.git_status, { desc = "Telescope git status" })
-- Colorscheme
vim.keymap.set("n", "<leader>cs", t_builtin.colorscheme, { desc = "Telescope open colorscheme" })

-- File Explorer
vim.keymap.set("n", "\\", "<Cmd>Oil<Cr>", { desc = "Oil file explorer" })

-- helper function to parse output
local function parse_output(proc)
	local result = proc:wait()
	local ret = {}
	if result.code == 0 then
		for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
			-- Remove trailing slash
			line = line:gsub("/$", "")
			ret[line] = true
		end
	end
	return ret
end

-- build git status cache
local function new_git_status()
	return setmetatable({}, {
		__index = function(self, key)
			local ignore_proc = vim.system(
				{ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
				{
					cwd = key,
					text = true,
				}
			)
			local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
				cwd = key,
				text = true,
			})
			local ret = {
				ignored = parse_output(ignore_proc),
				tracked = parse_output(tracked_proc),
			}

			rawset(self, key, ret)
			return ret
		end,
	})
end
local git_status = new_git_status()

-- Clear git status cache on refresh
local refresh = require("oil.actions").refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
	git_status = new_git_status()
	orig_refresh(...)
end

require("oil").setup {
	default_file_explorer = true,
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	-- Window-local options to use for oil buffers
	win_options = {
		wrap = false,
		signcolumn = "no",
		cursorcolumn = false,
		foldcolumn = "0",
		spell = false,
		list = true,
		conceallevel = 3,
		concealcursor = "nvic",
	},
	delete_to_trash = false,
	skip_confirm_for_simple_edits = false,
	prompt_save_on_select_new_entry = true,
	cleanup_delay_ms = 2000,
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = false,
	},
	constrain_cursor = "editable",
	watch_for_changes = true,
	keymaps = {
		["g?"] = { "actions.show_help", mode = "n" },
		["<CR>"] = "actions.select",
		["<C-s>"] = { "actions.select", opts = { vertical = true } },
		["<C-h>"] = { "actions.select", opts = { horizontal = true } },
		["<C-t>"] = { "actions.select", opts = { tab = true } },
		["<C-p>"] = "actions.preview",
		["<C-c>"] = { "actions.close", mode = "n" },
		["<C-l>"] = "actions.refresh",
		["-"] = { "actions.parent", mode = "n" },
		["_"] = { "actions.open_cwd", mode = "n" },
		["`"] = { "actions.cd", mode = "n" },
		["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
		["gs"] = { "actions.change_sort", mode = "n" },
		["gx"] = "actions.open_external",
		["g."] = { "actions.toggle_hidden", mode = "n" },
		["g\\"] = { "actions.toggle_trash", mode = "n" },
	},
	use_default_keymaps = true,
	view_options = {
		show_hidden = false,
		is_hidden_file = function(name, bufnr)
			local dir = require("oil").get_current_dir(bufnr)

			-- Explicitly hidden names
			local hidden_files = {
				[".git"] = true,
				[".."] = true,
			}

			-- Always hide explicitly configured files
			if hidden_files[name] then
				return true
			end

			-- If no local directory (e.g. ssh), we cannot determine git status
			if not dir then
				return false
			end

			local status = git_status[dir]
			if not status then
				return false
			end

			-- Hide gitignored files only
			return status.ignored[name] == true
		end,
	},
}
