local M = {}

function M:highlight(group, style)
	vim.cmd(
		"highlight "
			.. group
			.. " guifg="
			.. (style.fg and style.fg.gui or "NONE")
			.. " guibg="
			.. (style.bg and style.bg.gui or "NONE")
			.. " guisp="
			.. (style.sp and style.sp.gui or "NONE")
			.. " gui="
			.. (style.gui or "NONE")
			.. " ctermfg="
			.. (style.fg and style.fg.cterm or "NONE")
			.. " ctermbg="
			.. (style.bg and style.bg.cterm or "NONE")
			.. " cterm="
			.. (style.cterm or "NONE")
	)
end

function M:setup(opts)
	vim.cmd("hi clear")

	if vim.fn.exists("syntax on") ~= 0 then
		vim.cmd("syntax reset")
	end

	vim.g.colors_name = "paramounta"

	local s = {
		black = { gui = "#000000", cterm = "232" },
		medium_gray = { gui = "#767676", cterm = 243 },
		white = { gui = "#F1F1F1", cterm = "15" },
		actual_white = { gui = "#FFFFFF", cterm = "231" },
		subtle_black = { gui = "#303030", cterm = "236" },
		light_black = { gui = "#262626", cterm = "235" },
		lighter_black = { gui = "#4E4E4E", cterm = "239" },
		light_gray = { gui = "#A8A8A8", cterm = "248" },
		lighter_gray = { gui = "#C6C6C6", cterm = "251" },
		lightest_gray = { gui = "#EEEEEE", cterm = "255" },
		pink = { gui = "#fb007a", cterm = "9" },
		dark_red = { gui = "#C30771", cterm = "1" },
		light_red = { gui = "#E32791", cterm = "1" },
		orange = { gui = "#D75F5F", cterm = "167" },
		darker_blue = { gui = "#005F87", cterm = "18" },
		dark_blue = { gui = "#008EC4", cterm = "32" },
		blue = { gui = "#20BBFC", cterm = "12" },
		light_blue = { gui = "#b6d6fd", cterm = "153" },
		dark_cyan = { gui = "#20A5BA", cterm = "6" },
		light_cyan = { gui = "#4FB8CC", cterm = "14" },
		dark_green = { gui = "#10A778", cterm = "2" },
		light_green = { gui = "#5FD7A7", cterm = "10" },
		dark_purple = { gui = "#af5fd7", cterm = "134" },
		light_purple = { gui = "#a790d5", cterm = "140" },
		yellow = { gui = "#F3E430", cterm = "11" },
		light_yellow = { gui = "#ffff87", cterm = "228" },
		dark_yellow = { gui = "#A89C14", cterm = "3" },
		background = { gui = "NONE", cterm = "69" },
		gitSigns = {
			add = { gui = "#266d6a", cterm = "69" },
			change = { gui = "#536c9e", cterm = "69" },
			delete = { gui = "#b2555b", cterm = "69" },
		},
	}

	if vim.fn.exists("&background") == 1 and vim.o.background == "dark" then
		s.bg = s.black
		s.bg_subtle = s.lighter_black
		s.bg_very_subtle = s.subtle_black
		s.norm = s.lighter_gray
		s.norm_subtle = s.medium_gray
		s.purple = s.light_purple
		s.cyan = s.light_cyan
		s.green = s.light_green
		s.red = s.light_red
		s.visual = s.light_purple
		s.yellow = s.light_yellow
	else
		s.bg = s.actual_white
		s.bg_subtle = s.light_gray
		s.bg_very_subtle = s.lightest_gray
		s.norm = s.light_black
		s.norm_subtle = s.medium_gray
		s.purple = s.dark_purple
		s.cyan = s.dark_cyan
		s.green = s.dark_green
		s.red = s.dark_red
		s.visual = s.dark_purple
		s.yellow = s.dark_yellow
	end

	M:highlight("Cursor", { bg = s.purple, fg = s.norm })
	M:highlight("Comment", { fg = s.bg_subtle, gui = "italic" })

	M:highlight("Constant", { fg = s.purple })
	vim.cmd("hi! link Character Constant")
	vim.cmd("hi! link Number Constant")
	vim.cmd("hi! link Boolean Constant")
	vim.cmd("hi! link Float Constant")
	vim.cmd("hi! link String Constant")

	M:highlight("Identifier", { fg = s.dark_blue })
	vim.cmd("hi! link Identifier Normal")
	vim.cmd("hi! link Function Identifier")

	M:highlight("Statement", { fg = s.norm_subtle })
	vim.cmd("hi! link Conditional Statement")
	vim.cmd("hi! link Repeat Statement")
	vim.cmd("hi! link Label Statement")
	vim.cmd("hi! link Exception Statement")
	vim.cmd("hi! link @include Statement")
	M:highlight("Keyword", { fg = s.norm_subtle, gui = "italic" })

	M:highlight("Operator", { fg = s.norm, cterm = "bold", gui = "bold" })

	vim.cmd("hi! link PreProc Include")
	vim.cmd("hi! link PreProc Define")
	vim.cmd("hi! link PreProc Macro")
	vim.cmd("hi! link PreProc PreCondit")

	M:highlight("Type", { fg = s.norm })
	vim.cmd("hi! link Type StorageClass")
	vim.cmd("hi! link Type Structure")
	vim.cmd("hi! link Type Typedef")

	M:highlight("Special", { fg = s.norm_subtle, gui = "italic" })
	vim.cmd("hi! link Special SpecialChar")
	vim.cmd("hi! link Special Tag")
	vim.cmd("hi! link Special Delimiter")
	vim.cmd("hi! link Special SpecialComment")
	vim.cmd("hi! link Special Debug")

	M:highlight("Underlined", { fg = s.norm, gui = "underline", cterm = "underline" })
	M:highlight("Ignore", { fg = s.bg })
	M:highlight("Error", { fg = s.actual_white, bg = s.red, cterm = "bold" })
	M:highlight("Todo", { fg = s.purple, gui = "underline", cterm = "underline" })
	M:highlight("SpecialKey", { fg = s.light_green })
	M:highlight("NonText", { fg = s.medium_gray })
	M:highlight("Directory", { fg = s.dark_blue })
	M:highlight("ErrorMsg", { fg = s.red })
	M:highlight("IncSearch", { bg = s.yellow, fg = s.light_black })
	M:highlight("Search", { bg = s.light_green, fg = s.light_black })
	M:highlight("MoreMsg", { fg = s.medium_gray, cterm = "bold", gui = "bold" })
	vim.cmd("hi! link ModeMsg MoreMsg")
	M:highlight("LineNr", { fg = s.bg_subtle })
	M:highlight("CursorLineNr", { fg = s.purple, bg = s.bg_very_subtle })
	M:highlight("Question", { fg = s.red })
	M:highlight("StatusLine", { bg = s.bg_very_subtle })
	M:highlight("StatusLineNC", { bg = s.bg_very_subtle, fg = s.medium_gray })
	M:highlight("VertSplit", { bg = s.bg_very_subtle, fg = s.bg_very_subtle })
	M:highlight("Title", { fg = s.dark_blue })
	M:highlight("Visual", { bg = s.bg_very_subtle })
	M:highlight("VisualNOS", { bg = s.bg_subtle })
	M:highlight("WarningMsg", { fg = s.yellow })
	M:highlight("WildMenu", { fg = s.bg, bg = s.norm })
	M:highlight("Folded", { fg = s.medium_gray })
	M:highlight("FoldColumn", { fg = s.bg_subtle })
	M:highlight("DiffAdd", { fg = s.green })
	M:highlight("DiffDelete", { fg = s.red })
	M:highlight("DiffChange", { fg = s.dark_yellow })
	M:highlight("DiffText", { fg = s.dark_blue })
	M:highlight("SignColumn", { fg = s.light_green })

	if vim.fn.has("gui_running") == 1 then
		M:highlight("SpellBad", { gui = "underline", sp = s.red })
		M:highlight("SpellCap", { gui = "underline", sp = s.light_green })
		M:highlight("SpellRare", { gui = "underline", sp = s.pink })
		M:highlight("SpellLocal", { gui = "underline", sp = s.dark_green })
	else
		M:highlight("SpellBad", { cterm = "underline", fg = s.red })
		M:highlight("SpellCap", { cterm = "underline", fg = s.light_green })
		M:highlight("SpellRare", { cterm = "underline", fg = s.pink })
		M:highlight("SpellLocal", { cterm = "underline", fg = s.dark_green })
	end

	M:highlight("Pmenu", { fg = s.norm, bg = s.bg_subtle })
	M:highlight("PmenuSel", { fg = s.norm, bg = s.purple })
	M:highlight("PmenuSbar", { fg = s.norm, bg = s.bg_subtle })
	M:highlight("PmenuThumb", { fg = s.norm, bg = s.bg_subtle })
	M:highlight("TabLine", { fg = s.norm, bg = s.bg_very_subtle })
	M:highlight("TabLineSel", { fg = s.purple, bg = s.bg_subtle, gui = "bold", cterm = "bold" })
	M:highlight("TabLineFill", { fg = s.norm, bg = s.bg_very_subtle })
	M:highlight("CursorColumn", { bg = s.bg_very_subtle })
	M:highlight("CursorLine", { bg = s.bg_very_subtle })
	M:highlight("ColorColumn", { bg = s.bg_subtle })

	M:highlight("MatchParen", { bg = s.bg_subtle, fg = s.norm })
	M:highlight("qfLineNr", { fg = s.medium_gray })

	M:highlight("htmlH1", { bg = s.bg, fg = s.norm })
	M:highlight("htmlH2", { bg = s.bg, fg = s.norm })
	M:highlight("htmlH3", { bg = s.bg, fg = s.norm })
	M:highlight("htmlH4", { bg = s.bg, fg = s.norm })
	M:highlight("htmlH5", { bg = s.bg, fg = s.norm })
	M:highlight("htmlH6", { bg = s.bg, fg = s.norm })

	M:highlight("SyntasticWarningSign", { fg = s.yellow })
	M:highlight("SyntasticWarning", { bg = s.yellow, fg = s.black, gui = "bold", cterm = "bold" })
	M:highlight("SyntasticErrorSign", { fg = s.red })
	M:highlight("SyntasticError", { bg = s.red, fg = s.white, gui = "bold", cterm = "bold" })

	-- Neomake
	vim.cmd("hi link NeomakeWarningSign SyntasticWarningSign")
	vim.cmd("hi link NeomakeErrorSign SyntasticErrorSign")

	-- ALE
	vim.cmd("hi link ALEWarningSign SyntasticWarningSign")
	vim.cmd("hi link ALEErrorSign SyntasticErrorSign")

	-- Signify, git-gutter
	vim.cmd("hi link SignifySignAdd LineNr")
	vim.cmd("hi link SignifySignDelete LineNr")
	vim.cmd("hi link SignifySignChange LineNr")
	vim.cmd("hi link GitGutterAdd LineNr")
	vim.cmd("hi link GitGutterDelete LineNr")
	vim.cmd("hi link GitGutterChange LineNr")
	vim.cmd("hi link GitGutterChangeDelete LineNr")

	M:highlight("WinSeparator", { bg = "NONE", fg = s.light_black })

	M:highlight("DiagnosticError", { fg = s.orange, bg = "NONE" })
	M:highlight("DiagnosticWarn", { fg = s.yellow, bg = "NONE" })

	M:highlight("GitSignsAdd", { fg = s.gitSigns.add })
	M:highlight("GitSignsChange", { fg = s.gitSigns.change })
	M:highlight("GitSignsDelete", { fg = s.gitSigns.delete })

	M:highlight("TelescopeSelection", { bg = s.white, fg = s.black })

	M:highlight("MiniIndentscopeSymbol", { fg = s.light_blue })
end

return M
