vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true  -- Use terminal colours
vim.opt.relativenumber = true -- Show numbers relative to current line
vim.opt.number = true         -- Show absolute line number
vim.opt.wrap = false          -- Don't wrap strings
vim.opt.expandtab = true      -- Make tab use spaces
vim.opt.smarttab = true       -- Make tab go to next indent

vim.opt.shiftwidth = 2        -- Set the shiftwidth to 2 spaces
vim.opt.tabstop = 2           -- Set the tab to 2 spaces

vim.opt.signcolumn = "auto"   -- idk what this does

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

  update_in_insert = false,
})

-- Disable Built-in Objects
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwSettings = 1
-- vim.g.loaded_netrwFileHandlers = 1
-- vim.g.loaded_netrw_gitignore = 1
