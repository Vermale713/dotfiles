-- SYSTEM STUFF
local sysname = vim.loop.os_uname().sysname
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.clipboard = "unnamedplus"

-- NEOVIM STUFF
vim.opt.autoread = true -- Auto reload buffer

-- SHELL STUFF
if sysname == "Windows_NT" then
	vim.opt.shell = "pwsh"
	vim.opt.shellcmdflag = "-NoLogo"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
elseif sysname == "Darwin" then
elseif sysname == "Linux" then
end

-- TERMINAL STUFF
vim.opt.termguicolors = true -- Use terminal colours
vim.opt.relativenumber = true -- Show numbers relative to current line
vim.opt.number = true -- Show absolute line number
vim.opt.wrap = true -- Wrap if it reaches the end
vim.opt.expandtab = true -- Make tab use spaces
vim.opt.smarttab = true -- Make tab go to next indent
vim.opt.shiftwidth = 4 -- Set the shiftwidth to 4 spaces
vim.opt.tabstop = 4 -- Set the tab to 4 spaces
vim.opt.signcolumn = "yes" -- make the signcolumn always show

vim.diagnostic.config({

	underline = true,

	virtual_text = {

		prefix = "",

		severity = nil,

		source = "if_many",

		format = nil,
	},

	signs = true,

	severity_sort = true,

	update_in_insert = true,
})

-- Disable Built-in Objects
--vim.g.loaded_netrwPlugin = 1
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwSettings = 1
--vim.g.loaded_netrwFileHandlers = 1
--vim.g.loaded_netrw_gitignore = 1
