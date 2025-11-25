local builtin = require("telescope.builtin")

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = false }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Explorer
map("n", "<leader>pv", "<CMD>Ex<CR>")
map("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>sg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>sb", builtin.buffers, { desc = "Telescope open buffers" })
-- Git
map("n", "<leader>gc", builtin.git_commits, { desc = "Telescope git commits" })
map("n", "<leader>gbc", builtin.git_bcommits, { desc = "Telescope git commits" })
map("n", "<leader>gbr", builtin.git_branches, { desc = "Telescope git commits" })
map("n", "<leader>gs", builtin.git_status, { desc = "Telescope git commits" })
-- Colorscheme
map("n", "<leader>sc", builtin.colorscheme, { desc = "Telescope colorschemes" })
-- Window Splits
map("n", "<A-v>", "<C-w>v")
map("n", "<A-s>", "<C-w>s")
-- Window Split Navigating
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
-- Terminal Navigating
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "<A-h>", "<CMD>wincmd h<CR>")
map("t", "<A-j>", "<CMD>wincmd j<CR>")
map("t", "<A-k>", "<CMD>wincmd k<CR>")
map("t", "<A-l>", "<CMD>wincmd l<CR>")
-- Formatting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<leader>fa", "<CMD>lua require('conform').format({async = true})<CR>")
-- Buffers and Tabs
map("n", "<TAB>", "<CMD>bn<CR>")
map("n", "<S-TAB>", "<CMD>bp<CR>")
