function Map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = false }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Explorer
-- Map("n","<leader>pv","<Cmd>Ex<CR>")
-- ^^ Using snacks explorer instead of netrw

-- Windows Splits
Map("n", "<A-v>", "<C-w>v")
Map("n", "<A-s>", "<C-w>s")
-- Window Split Moving
Map("n", "<A-h>", "<C-w>h")
Map("n", "<A-l>", "<C-w>l")
Map("n", "<A-j>", "<C-w>j")
Map("n", "<A-k>", "<C-w>k")

Map("t", "<A-h>", "<CMD>wincmd h<CR>")
Map("t", "<A-l>", "<CMD>wincmd l<CR>")
Map("t", "<A-j>", "<CMD>wincmd j<CR>")
Map("t", "<A-k>", "<CMD>wincmd k<CR>")

-- Text Editing
Map("v", "J", ":m '>+1<CR>gv=gv")
Map("v", "K", ":m '<-2<CR>gv=gv")
Map("v", "<", "<gv")
Map("v", ">", ">gv")
Map("n", "<leader>fa", "<CMD>lua require('conform').format({async = true})<CR>")

-- Buffers and Tabs
Map("n", "<TAB>", ":bn<CR>")
Map("n", "<S-TAB>", ":bp<CR>")
