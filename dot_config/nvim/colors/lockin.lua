-- lockin: a quiet, warm theme built for long stretches of focused work.
vim.cmd "highlight clear"
if vim.fn.exists "syntax_on" == 1 then
	vim.cmd "syntax reset"
end

vim.g.colors_name = "lockin"

local c = {
	bg = "#101110",
	bg_alt = "#161816",
	bg_elevated = "#1c1f1c",
	bg_visual = "#2a2d27",
	border = "#30342f",
	fg = "#e7e2d8",
	fg_soft = "#c7c2b8",
	muted = "#8d8b83",
	subtle = "#62655f",
	comment = "#73766e",
	amber = "#d0a866",
	amber_bright = "#e0ba78",
	sage = "#9caf88",
	blue = "#8fa7b3",
	cyan = "#89aaa4",
	red = "#c4776e",
	purple = "#aa95b5",
	add = "#263127",
	change = "#303024",
	delete = "#352522",
}

local groups = {
	-- Editor chrome
	Normal = { fg = c.fg, bg = c.bg },
	NormalNC = { fg = c.fg_soft, bg = c.bg },
	NormalFloat = { fg = c.fg, bg = c.bg_alt },
	FloatBorder = { fg = c.border, bg = c.bg_alt },
	FloatTitle = { fg = c.amber, bg = c.bg_alt, bold = true },
	Cursor = { fg = c.bg, bg = c.fg },
	lCursor = { link = "Cursor" },
	CursorIM = { link = "Cursor" },
	CursorLine = { bg = c.bg_alt },
	CursorColumn = { bg = c.bg_alt },
	ColorColumn = { bg = c.bg_alt },
	LineNr = { fg = c.subtle },
	LineNrAbove = { fg = c.subtle },
	LineNrBelow = { fg = c.subtle },
	CursorLineNr = { fg = c.amber_bright, bold = true },
	SignColumn = { fg = c.subtle, bg = c.bg },
	FoldColumn = { fg = c.subtle, bg = c.bg },
	Folded = { fg = c.muted, bg = c.bg_alt, italic = true },
	WinSeparator = { fg = c.border },
	VertSplit = { link = "WinSeparator" },
	StatusLine = { fg = c.fg_soft, bg = c.bg_elevated },
	StatusLineNC = { fg = c.subtle, bg = c.bg_alt },
	TabLine = { fg = c.muted, bg = c.bg_alt },
	TabLineFill = { bg = c.bg },
	TabLineSel = { fg = c.fg, bg = c.bg_elevated, bold = true },
	WinBar = { fg = c.fg_soft, bg = c.bg },
	WinBarNC = { fg = c.subtle, bg = c.bg },

	-- Interaction
	Visual = { bg = c.bg_visual },
	VisualNOS = { link = "Visual" },
	Search = { fg = c.bg, bg = c.sage },
	IncSearch = { fg = c.bg, bg = c.amber_bright, bold = true },
	CurSearch = { link = "IncSearch" },
	Substitute = { fg = c.bg, bg = c.red },
	MatchParen = { fg = c.amber_bright, bold = true },
	Pmenu = { fg = c.fg_soft, bg = c.bg_elevated },
	PmenuSel = { fg = c.bg, bg = c.amber, bold = true },
	PmenuMatch = { fg = c.amber_bright, bg = c.bg_elevated, bold = true },
	PmenuMatchSel = { fg = c.bg, bg = c.amber, bold = true },
	PmenuSbar = { bg = c.bg_alt },
	PmenuThumb = { bg = c.border },
	WildMenu = { fg = c.bg, bg = c.amber },
	QuickFixLine = { bg = c.bg_visual, bold = true },

	-- Messages and miscellaneous text
	Title = { fg = c.amber_bright, bold = true },
	Directory = { fg = c.blue },
	Question = { fg = c.sage },
	MoreMsg = { fg = c.sage },
	ModeMsg = { fg = c.fg_soft, bold = true },
	WarningMsg = { fg = c.amber },
	ErrorMsg = { fg = c.red, bold = true },
	NonText = { fg = c.border },
	Whitespace = { fg = c.border },
	SpecialKey = { fg = c.subtle },
	EndOfBuffer = { fg = c.bg },
	Conceal = { fg = c.muted },

	-- Classic syntax (also serves as Tree-sitter fallbacks)
	Comment = { fg = c.comment, italic = true },
	Constant = { fg = c.purple },
	String = { fg = c.sage },
	Character = { fg = c.sage },
	Number = { fg = c.purple },
	Boolean = { fg = c.purple, bold = true },
	Float = { link = "Number" },
	Identifier = { fg = c.fg },
	Function = { fg = c.blue },
	Statement = { fg = c.amber },
	Conditional = { fg = c.amber },
	Repeat = { fg = c.amber },
	Label = { fg = c.amber_bright },
	Operator = { fg = c.muted },
	Keyword = { fg = c.amber },
	Exception = { fg = c.red },
	PreProc = { fg = c.cyan },
	Include = { fg = c.amber },
	Define = { fg = c.cyan },
	Macro = { fg = c.cyan },
	Type = { fg = c.cyan },
	StorageClass = { fg = c.amber },
	Structure = { fg = c.cyan },
	Typedef = { fg = c.cyan },
	Special = { fg = c.amber_bright },
	SpecialChar = { fg = c.amber_bright },
	Tag = { fg = c.blue },
	Delimiter = { fg = c.muted },
	SpecialComment = { fg = c.comment, bold = true },
	Debug = { fg = c.red },
	Underlined = { fg = c.blue, underline = true },
	Ignore = { fg = c.subtle },
	Error = { fg = c.red },
	Todo = { fg = c.bg, bg = c.amber, bold = true },

	-- Diagnostics
	DiagnosticError = { fg = c.red },
	DiagnosticWarn = { fg = c.amber },
	DiagnosticInfo = { fg = c.blue },
	DiagnosticHint = { fg = c.sage },
	DiagnosticOk = { fg = c.sage },
	DiagnosticVirtualTextError = { fg = c.red, bg = c.delete },
	DiagnosticVirtualTextWarn = { fg = c.amber, bg = c.change },
	DiagnosticVirtualTextInfo = { fg = c.blue, bg = c.bg_alt },
	DiagnosticVirtualTextHint = { fg = c.sage, bg = c.bg_alt },
	DiagnosticUnderlineError = { undercurl = true, sp = c.red },
	DiagnosticUnderlineWarn = { undercurl = true, sp = c.amber },
	DiagnosticUnderlineInfo = { undercurl = true, sp = c.blue },
	DiagnosticUnderlineHint = { undercurl = true, sp = c.sage },

	-- Diffs and version control
	DiffAdd = { bg = c.add },
	DiffChange = { bg = c.change },
	DiffDelete = { fg = c.red, bg = c.delete },
	DiffText = { fg = c.fg, bg = "#3c3926", bold = true },
	Added = { fg = c.sage },
	Changed = { fg = c.amber },
	Removed = { fg = c.red },
	GitSignsAdd = { fg = c.sage },
	GitSignsChange = { fg = c.amber },
	GitSignsDelete = { fg = c.red },

	-- Telescope
	TelescopeNormal = { fg = c.fg_soft, bg = c.bg_alt },
	TelescopeBorder = { fg = c.border, bg = c.bg_alt },
	TelescopeTitle = { fg = c.bg, bg = c.amber, bold = true },
	TelescopePromptNormal = { fg = c.fg, bg = c.bg_elevated },
	TelescopePromptBorder = { fg = c.border, bg = c.bg_elevated },
	TelescopePromptPrefix = { fg = c.amber },
	TelescopeSelection = { fg = c.fg, bg = c.bg_visual, bold = true },
	TelescopeSelectionCaret = { fg = c.amber, bg = c.bg_visual },
	TelescopeMatching = { fg = c.amber_bright, bold = true },

	-- Oil and completion documentation
	OilDir = { fg = c.blue, bold = true },
	OilDirIcon = { fg = c.blue },
	OilLink = { fg = c.cyan, underline = true },
	OilSocket = { fg = c.purple },
	OilCreate = { fg = c.sage },
	OilDelete = { fg = c.red },
	OilMove = { fg = c.amber },
	BlinkCmpMenu = { fg = c.fg_soft, bg = c.bg_elevated },
	BlinkCmpMenuSelection = { fg = c.bg, bg = c.amber },
	BlinkCmpLabelMatch = { fg = c.amber_bright, bold = true },
	BlinkCmpDoc = { fg = c.fg_soft, bg = c.bg_alt },
	BlinkCmpDocBorder = { fg = c.border, bg = c.bg_alt },
}

local links = {
	-- Tree-sitter captures
	["@comment"] = "Comment",
	["@comment.documentation"] = "SpecialComment",
	["@constant"] = "Constant",
	["@constant.builtin"] = "Special",
	["@string"] = "String",
	["@string.escape"] = "SpecialChar",
	["@string.regexp"] = "SpecialChar",
	["@character"] = "Character",
	["@number"] = "Number",
	["@number.float"] = "Float",
	["@boolean"] = "Boolean",
	["@variable"] = "Identifier",
	["@variable.builtin"] = "Special",
	["@variable.parameter"] = "Identifier",
	["@variable.member"] = "Identifier",
	["@function"] = "Function",
	["@function.call"] = "Function",
	["@function.builtin"] = "Special",
	["@function.method"] = "Function",
	["@function.method.call"] = "Function",
	["@constructor"] = "Type",
	["@keyword"] = "Keyword",
	["@keyword.function"] = "Keyword",
	["@keyword.return"] = "Keyword",
	["@keyword.operator"] = "Keyword",
	["@keyword.import"] = "Include",
	["@keyword.exception"] = "Exception",
	["@type"] = "Type",
	["@type.builtin"] = "Type",
	["@type.definition"] = "Typedef",
	["@attribute"] = "PreProc",
	["@property"] = "Identifier",
	["@operator"] = "Operator",
	["@punctuation.delimiter"] = "Delimiter",
	["@punctuation.bracket"] = "Delimiter",
	["@punctuation.special"] = "Special",
	["@tag"] = "Tag",
	["@tag.attribute"] = "Identifier",
	["@markup.heading"] = "Title",
	["@markup.link"] = "Underlined",
	["@markup.raw"] = "String",
	["@markup.list"] = "Special",
	["@diff.plus"] = "Added",
	["@diff.delta"] = "Changed",
	["@diff.minus"] = "Removed",

}

for name, spec in pairs(groups) do
	vim.api.nvim_set_hl(0, name, spec)
end

for name, target in pairs(links) do
	vim.api.nvim_set_hl(0, name, { link = target })
end

-- Semantic tokens are intentionally transparent. Luau-LSP occasionally marks
-- grammar tokens (notably the `function` keyword) as functions; letting
-- Tree-sitter own syntax colour avoids mismatched keyword pairs.
for _, token in ipairs {
	"comment",
	"string",
	"number",
	"keyword",
	"function",
	"method",
	"type",
	"class",
	"interface",
	"enum",
	"property",
	"parameter",
	"variable",
	"namespace",
} do
	vim.api.nvim_set_hl(0, "@lsp.type." .. token, {})
	vim.api.nvim_set_hl(0, "@lsp.type." .. token .. ".luau", {})
end

-- Luau's query uses compound captures such as @keyword.function.  Define the
-- language-qualified groups explicitly so Neovim cannot fall back to the
-- misleading @function group (which is intentionally blue for callable names).
local luau_links = {
	-- Names stay neutral even when their binding is immutable. This keeps the
	-- same identifier visually stable between its declaration and later uses.
	["@constant.luau"] = "Identifier",
	["@keyword.function.luau"] = "Keyword",
	["@keyword.control.luau"] = "Keyword",
	["@keyword.control.return.luau"] = "Keyword",
	["@keyword.control.conditional.luau"] = "Keyword",
	["@keyword.control.repeat.luau"] = "Keyword",
	["@keyword.operator.luau"] = "Keyword",
	["@keyword.storage.type.luau"] = "Keyword",
	["@keyword.storage.modifier.luau"] = "Keyword",
	["@keyword.directive.luau"] = "PreProc",
	["@namespace.luau"] = "Identifier",
	["@variable.other.member.luau"] = "Identifier",
	["@function.luau"] = "Function",
	["@function.method.luau"] = "Function",
}

for name, target in pairs(luau_links) do
	vim.api.nvim_set_hl(0, name, { link = target })
end
