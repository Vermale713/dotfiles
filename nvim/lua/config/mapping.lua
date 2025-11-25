local function map(mode,lhs,rhs,opts)
	local options = { noremap = true, silent = false }
	if opts then
		options = vim.tbl_extend("force",options,opts)
	end
	vim.keymap.set(mode,lhs,rhs,options)
end

-- Explorer
map("n","<leader>pv","<CMD>Ex<CR>")
-- Window Splits
map("n","<A-v>","<C-w>v")
map("n","<A-s>","<C-w>s")
-- Window Split Navigating
map("n","<A-h>","<C-w>h")
map("n","<A-j>","<C-w>j")
map("n","<A-k>","<C-w>k")
map("n","<A-l>","<C-w>l")
map("t","<A-h>","<CMD>wincmd h<CR>")
map("t","<A-j>","<CMD>wincmd j<CR>")
map("t","<A-k>","<CMD>wincmd k<CR>")
map("t","<A-l>","<CMD>wincmd l<CR>")
-- Formatting
map("v","<","<gv")
map("v",">",">gv")
map("n","<leader>fa","<CMD>lua require('conform').format({async = true})<CR>")
-- Buffers and Tabs
map("n","<TAB>","<CMD>bn<CR>")
map("n","<S-TAB>","<CMD>bp<CR>")
