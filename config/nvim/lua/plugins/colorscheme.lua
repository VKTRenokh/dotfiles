return {
	"tjdevries/colorbuddy.nvim",
	dependencies = {
		"svrana/neosolarized.nvim",
		"folke/tokyonight.nvim",
		"ellisonleao/gruvbox.nvim",
    "marko-cerovac/material.nvim",
	},
	config = function()
		local n = require("neosolarized")

		n.setup({
			comment_italics = true,
		})

		local cb = require("colorbuddy.init")
		local Color = cb.Color
		local colors = cb.colors
		local Group = cb.Group
		local groups = cb.groups
		local styles = cb.styles

		Color.new("black", "#000000")
		Group.new("CursorLine", colors.none, colors.base03, styles.NONE, colors.base1)
		Group.new("CursorLineNr", colors.yellow, colors.none, styles.NONE, colors.base1)
		Group.new("Visual", colors.none, colors.base03, styles.reverse)

		local cError = groups.Error.fg
		local cInfo = groups.Information.fg
		local cWarn = groups.Warning.fg
		local cHint = groups.Hint.fg

		Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
		Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
		Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
		Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
		Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
		Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
		Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
		Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

		local tokyonight = require("tokyonight")

		tokyonight.setup({
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
				keywords = { italic = false },
				comments = { italic = false },
				functions = { italic = false },
				variables = { italic = false },
			},
		})

    vim.g.material_style = "oceanic"

    local material = require("material")

    material.setup {
      disable = {
        background = true,
      },
    }

		vim.cmd([[
      try
        colorscheme tokyonight-night
      catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
      endtry
    ]])
	end,
}
