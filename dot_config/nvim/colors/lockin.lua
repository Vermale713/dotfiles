local c = {
	bg = "#111111",
	bg_alt = "#181818",
	bg_highlight = "#242424",
	fg = "#e8e6e0", -- slightly dimmed from f0eee8, less glare
	muted = "#948f88", -- desaturated further, more gray than tan
	comment = "#5c5b57", -- pure gray-ish, was slightly warm
	dim = "#87847e", -- new: for "important but not colored" text
	accent = "#c9a36a", -- single accent hue (was "amber"), slightly desaturated
	red = "#b56464", -- desaturated, only for real errors
}

vim.cmd "highlight clear"
if vim.fn.exists "syntax_on" then
	vim.cmd "syntax reset"
end
vim.g.colors_name = "lockin"

local set = vim.api.nvim_set_hl
local highlights = {
	Normal = { fg = c.fg, bg = c.bg },
	NormalFloat = { fg = c.fg, bg = c.bg_alt },
	CursorLine = { bg = c.bg_alt },
	CursorLineNr = { fg = c.accent }, -- dropped bold, still readable
	LineNr = { fg = c.comment },
	ColorColumn = { bg = c.bg_alt },
	SignColumn = { bg = c.bg },
	VertSplit = { fg = c.bg_highlight },
	WinSeparator = { fg = c.bg_highlight },
	StatusLine = { fg = c.muted, bg = c.bg_alt },
	StatusLineNC = { fg = c.comment, bg = c.bg_alt },
	Visual = { bg = c.bg_highlight },
	Search = { fg = c.bg, bg = c.muted }, -- was accent; search shouldn't scream
	IncSearch = { fg = c.bg, bg = c.accent },
	CurSearch = { fg = c.bg, bg = c.accent },
	Pmenu = { fg = c.fg, bg = c.bg_alt },
	PmenuSel = { fg = c.bg, bg = c.muted },
	PmenuSbar = { bg = c.bg_highlight },
	PmenuThumb = { bg = c.muted },
	FloatBorder = { fg = c.bg_highlight, bg = c.bg_alt },
	Title = { fg = c.accent },
	Directory = { fg = c.dim },
	MatchParen = { underline = true, sp = c.accent }, -- no bold, no bg pop
	NonText = { fg = c.comment },
	Whitespace = { fg = c.comment },

	-- syntax: near-monochrome, one accent for structure only
	Comment = { fg = c.comment, italic = true },
	Constant = { fg = c.dim },
	String = { fg = c.dim },
	Identifier = { fg = c.fg },
	Function = { fg = c.fg },
	Statement = { fg = c.accent },
	Keyword = { fg = c.accent },
	Type = { fg = c.dim },
	Special = { fg = c.muted },
	Error = { fg = c.red },
	Todo = { fg = c.accent, bold = true }, -- ok to keep loud, it's rare/intentional

	DiagnosticError = { fg = c.red },
	DiagnosticWarn = { fg = c.accent },
	DiagnosticInfo = { fg = c.muted },
	DiagnosticHint = { fg = c.comment },
	DiagnosticUnderlineError = { undercurl = true, sp = c.red },
	DiagnosticUnderlineWarn = { undercurl = true, sp = c.accent },
	DiagnosticUnderlineInfo = { undercurl = true, sp = c.muted },
	DiagnosticUnderlineHint = { undercurl = true, sp = c.comment },

	DiffAdd = { bg = "#1a201a" },
	DiffChange = { bg = "#1e1f1a" },
	DiffDelete = { fg = c.red, bg = "#241a1a" },
	DiffText = { bg = "#292a1c" },

	["@comment"] = { link = "Comment" },
	["@string"] = { link = "String" },
	["@number"] = { link = "Constant" },
	["@function"] = { link = "Function" },
	["@keyword"] = { link = "Keyword" },
	["@type"] = { link = "Type" },
	["@variable"] = { fg = c.fg },
}

for group, opts in pairs(highlights) do
	set(0, group, opts)
end
