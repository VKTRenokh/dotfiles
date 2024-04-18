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
		keys = {
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
		enabled = true,
		init = function()
			vim.g.unception_block_while_host_edits = true
		end,
	},
	-- }}}
	-- {{{ mini.bufremove
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0)
				end,
				desc = "Delete Buffer",
			},
    -- stylua: ignore
    { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
		},
	},
	-- }}}
}
