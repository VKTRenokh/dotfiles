Is_Enabled = require("config.functions").is_enabled
Customize = require("config.customize")

return {
	-- {{{ plenary
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ toggleterm.nvim
	{
		"akinsho/toggleterm.nvim",
		enabled = Is_Enabled("toggleterm.nvim"),
		keys = {
			{
				"<leader>Tg",
				function()
					Customize.toggleterm.lazygit()
				end,
			},
			{
				"<leader>TT",
				"<Cmd>ToggleTerm<cr>",
			},
		},
		-- cmd = "ToggleTerm",
		version = "*",
		opts = {
			size = 13,
			open_mapping = [[<c-\>]],
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = "1",
			start_in_insert = true,
			persist_size = true,
			direction = "float",
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ vim-fugitive
	{
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
		keys = {
			{ "<leader>g", "<cmd>G<cr>", desc = "open fugitive" },
			{ "<leader>G", "<cmd>Gvdiffsplit<cr>", desc = "git diff vertical split" },
		},
		enabled = Is_Enabled("vim-fugitive"),
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ gist.nvim
	{
		"Rawnly/gist.nvim",
		dependencies = { "samjwill/nvim-unception" },
		cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
	},
	{
		"samjwill/nvim-unception",
		lazy = false,
		init = function()
			vim.g.unception_block_while_host_edits = true
		end,
	},
	-- }}}
	-- {{{
	{
		"vuki656/package-info.nvim",
		dependencies = {
			"nui.nvim",
		},
		keys = {
			{
				"<leader>ns",
				"<cmd>lua require('package-info').show()<cr>",
			},
		},
	},
	-- }}}
}
