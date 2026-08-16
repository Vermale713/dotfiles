-- lockin: a quiet, warm theme built for long stretches of focused work.
vim.cmd "highlight clear"
if vim.fn.exists "syntax_on" == 1 then
	vim.cmd "syntax reset"
end

vim.g.colors_name = "lockin"

local c = {
	bg = "#111111",
	bg_alt = "#181818",
	bg_highlight = "#242424",

	fg = "#e8e6e0",
	dim = "#aaa69f",
	muted = "#7b7974",
	comment = "#5c5b57",

	amber = "#c9a36a",
	blue = "#8fa4b8",

	red = "#b56464",

	add = "#1c251f",
	change = "#282319",
	delete = "#281c1c",
}

local groups = {
	-- Editor chrome
	Normal = { fg = c.fg, bg = c.bg },
	NormalNC = { fg = c.dim, bg = c.bg },
	NormalFloat = { fg = c.fg, bg = c.bg_alt },
	FloatBorder = { fg = c.muted, bg = c.bg_alt },
	FloatTitle = { fg = c.amber, bg = c.bg_alt, bold = true },

	Cursor = { fg = c.bg, bg = c.fg },
	lCursor = { link = "Cursor" },
	CursorIM = { link = "Cursor" },

	CursorLine = { bg = c.bg_alt },
	CursorColumn = { bg = c.bg_alt },
	ColorColumn = { bg = c.bg_alt },

	LineNr = { fg = c.comment },
	LineNrAbove = { fg = c.comment },
	LineNrBelow = { fg = c.comment },
	CursorLineNr = { fg = c.amber, bold = true },

	SignColumn = { fg = c.muted, bg = c.bg },
	FoldColumn = { fg = c.muted, bg = c.bg },
	Folded = { fg = c.muted, bg = c.bg_alt, italic = true },

	WinSeparator = { fg = c.bg_highlight },
	VertSplit = { link = "WinSeparator" },

	StatusLine = { fg = c.dim, bg = c.bg_highlight },
	StatusLineNC = { fg = c.muted, bg = c.bg_alt },

	TabLine = { fg = c.muted, bg = c.bg_alt },
	TabLineFill = { bg = c.bg },
	TabLineSel = { fg = c.fg, bg = c.bg_highlight, bold = true },

	WinBar = { fg = c.dim, bg = c.bg },
	WinBarNC = { fg = c.muted, bg = c.bg },

	-- Interaction
	Visual = { bg = c.bg_highlight },
	VisualNOS = { link = "Visual" },

	Search = { fg = c.bg, bg = c.amber },
	IncSearch = { fg = c.bg, bg = c.amber, bold = true },
	CurSearch = { link = "IncSearch" },
	Substitute = { fg = c.bg, bg = c.red },

	MatchParen = { fg = c.amber, bold = true },

	Pmenu = { fg = c.dim, bg = c.bg_highlight },
	PmenuSel = { fg = c.bg, bg = c.amber, bold = true },
	PmenuMatch = { fg = c.amber, bg = c.bg_highlight, bold = true },
	PmenuMatchSel = { fg = c.bg, bg = c.amber, bold = true },
	PmenuSbar = { bg = c.bg_alt },
	PmenuThumb = { bg = c.muted },

	WildMenu = { fg = c.bg, bg = c.amber },
	QuickFixLine = { bg = c.bg_highlight, bold = true },

	-- Messages and miscellaneous text
	Title = { fg = c.amber, bold = true },
	Directory = { fg = c.blue },

	Question = { fg = c.dim },
	MoreMsg = { fg = c.dim },
	ModeMsg = { fg = c.dim, bold = true },

	WarningMsg = { fg = c.amber },
	ErrorMsg = { fg = c.red, bold = true },

	NonText = { fg = c.bg_highlight },
	Whitespace = { fg = c.bg_highlight },
	SpecialKey = { fg = c.muted },
	EndOfBuffer = { fg = c.bg },
	Conceal = { fg = c.muted },

	-- Classic syntax
	Comment = { fg = c.comment, italic = true },

	Constant = { fg = c.dim },
	String = { fg = c.dim },
	Character = { fg = c.dim },
	Number = { fg = c.dim },
	Boolean = { fg = c.dim, bold = true },
	Float = { link = "Number" },

	Identifier = { fg = c.fg },

	Function = { fg = c.blue },

	-- Language structure / declarations
	Statement = { fg = c.amber },
	Conditional = { fg = c.amber },
	Repeat = { fg = c.amber },
	Label = { fg = c.amber },
	Keyword = { fg = c.amber },
	StorageClass = { fg = c.amber },

	Operator = { fg = c.muted },

	Exception = { fg = c.red },

	PreProc = { fg = c.dim },
	Include = { fg = c.dim },
	Define = { fg = c.dim },
	Macro = { fg = c.dim },

	Type = { fg = c.dim },
	Structure = { fg = c.dim },
	Typedef = { fg = c.dim },

	Special = { fg = c.dim },
	SpecialChar = { fg = c.dim },

	Tag = { fg = c.blue },
	Delimiter = { fg = c.muted },

	SpecialComment = { fg = c.comment, bold = true },

	Debug = { fg = c.red },
	Underlined = { fg = c.blue, underline = true },
	Ignore = { fg = c.comment },
	Error = { fg = c.red },

	Todo = { fg = c.bg, bg = c.amber, bold = true },

	-- Diagnostics
	DiagnosticError = { fg = c.red },
	DiagnosticWarn = { fg = c.amber },
	DiagnosticInfo = { fg = c.blue },
	DiagnosticHint = { fg = c.muted },
	DiagnosticOk = { fg = c.dim },

	DiagnosticVirtualTextError = { fg = c.red, bg = c.delete },
	DiagnosticVirtualTextWarn = { fg = c.amber, bg = c.change },
	DiagnosticVirtualTextInfo = { fg = c.blue, bg = c.bg_alt },
	DiagnosticVirtualTextHint = { fg = c.muted, bg = c.bg_alt },

	DiagnosticUnderlineError = { undercurl = true, sp = c.red },
	DiagnosticUnderlineWarn = { undercurl = true, sp = c.amber },
	DiagnosticUnderlineInfo = { undercurl = true, sp = c.blue },
	DiagnosticUnderlineHint = { undercurl = true, sp = c.muted },

	-- Unused / unnecessary code should recede.
	DiagnosticUnnecessary = { fg = c.comment },

	-- Diffs and version control
	DiffAdd = { bg = c.add },
	DiffChange = { bg = c.change },
	DiffDelete = { fg = c.red, bg = c.delete },
	DiffText = { fg = c.fg, bg = c.bg_highlight, bold = true },

	Added = { fg = c.dim },
	Changed = { fg = c.amber },
	Removed = { fg = c.red },

	GitSignsAdd = { fg = c.dim },
	GitSignsChange = { fg = c.amber },
	GitSignsDelete = { fg = c.red },

	-- Telescope
	TelescopeNormal = { fg = c.dim, bg = c.bg_alt },
	TelescopeBorder = { fg = c.bg_highlight, bg = c.bg_alt },
	TelescopeTitle = { fg = c.bg, bg = c.amber, bold = true },

	TelescopePromptNormal = { fg = c.fg, bg = c.bg_highlight },
	TelescopePromptBorder = { fg = c.muted, bg = c.bg_highlight },
	TelescopePromptPrefix = { fg = c.amber },

	TelescopeSelection = {
		fg = c.fg,
		bg = c.bg_highlight,
		bold = true,
	},
	TelescopeSelectionCaret = {
		fg = c.amber,
		bg = c.bg_highlight,
	},
	TelescopeMatching = { fg = c.amber, bold = true },

	-- Oil
	OilDir = { fg = c.blue, bold = true },
	OilDirIcon = { fg = c.blue },
	OilLink = { fg = c.blue, underline = true },
	OilSocket = { fg = c.dim },

	OilCreate = { fg = c.dim },
	OilDelete = { fg = c.red },
	OilMove = { fg = c.amber },

	-- Blink completion
	BlinkCmpMenu = { fg = c.dim, bg = c.bg_highlight },
	BlinkCmpMenuSelection = { fg = c.bg, bg = c.amber },
	BlinkCmpLabelMatch = { fg = c.amber, bold = true },

	BlinkCmpDoc = { fg = c.dim, bg = c.bg_alt },
	BlinkCmpDocBorder = { fg = c.bg_highlight, bg = c.bg_alt },
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
	["@variable.builtin"] = "Identifier",
	["@variable.parameter"] = "Identifier",
	["@variable.member"] = "Identifier",

	["@function"] = "Function",
	["@function.call"] = "Function",
	["@function.builtin"] = "Function",
	["@function.method"] = "Function",
	["@function.method.call"] = "Function",

	["@constructor"] = "Type",

	["@keyword"] = "Keyword",
	["@keyword.function"] = "Keyword",
	["@keyword.return"] = "Keyword",
	["@keyword.operator"] = "Keyword",
	["@keyword.import"] = "Keyword",
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

-- Let Tree-sitter own syntax coloring. Semantic tokens remain available for
-- modifiers such as unused/unnecessary, but do not override syntax categories.
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

-- Dim symbols marked unnecessary/unused by the language server.
vim.api.nvim_set_hl(0, "@lsp.mod.unnecessary", {
	fg = c.comment,
})

vim.api.nvim_set_hl(0, "@lsp.mod.unnecessary.luau", {
	fg = c.comment,
})

local luau_links = {
	-- Identifiers stay neutral.
	["@constant.luau"] = "Identifier",
	["@namespace.luau"] = "Identifier",
	["@variable.other.member.luau"] = "Identifier",

	-- Declaration and control-flow grammar use the same structural colour.
	--
	-- Example:
	--   const function b() end
	--   ^^^^^ ^^^^^^^^     ^^^
	--   amber amber         amber
	["@keyword.function.luau"] = "Keyword",
	["@keyword.control.luau"] = "Keyword",
	["@keyword.control.return.luau"] = "Keyword",
	["@keyword.control.conditional.luau"] = "Keyword",
	["@keyword.control.repeat.luau"] = "Keyword",
	["@keyword.operator.luau"] = "Keyword",

	["@keyword.storage.type.luau"] = "Keyword",
	["@keyword.storage.modifier.luau"] = "Keyword",

	["@keyword.directive.luau"] = "PreProc",

	-- Callable names use the secondary hue.
	["@function.luau"] = "Function",
	["@function.call.luau"] = "Function",
	["@function.method.luau"] = "Function",
	["@function.method.call.luau"] = "Function",
}

for name, target in pairs(luau_links) do
	vim.api.nvim_set_hl(0, name, { link = target })
end
