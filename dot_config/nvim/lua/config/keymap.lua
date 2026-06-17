vim.g.leader = " "
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>od", "<Cmd>lua vim.diagnostic.open_float()<Cr>")
-- Window splits
vim.keymap.set("n", "<A-v>", "<C-w>v")
vim.keymap.set("n", "<A-s>", "<C-w>s")
-- Window split navigating
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")
-- Buffers
vim.keymap.set("n", "<Tab>", "<Cmd>bn<Cr>")
vim.keymap.set("n", "<S-Tab>", "<Cmd>bp<Cr>")
vim.keymap.set("n", "<leader>bd", "<Cmd>bdelete<Cr>")
