return {
	-- {{{ Comment.nvim
	{
		"echasnovski/mini.comment",
		event = "LazyFile",
		opts = {
			options = {
				custom_commentstring = nil,
				ignore_blank_line = false,
				start_of_line = false,
				pad_comment_parts = true,
			},
			mappings = {
				comment = "gc",
				comment_line = "gcc",
				comment_visual = "gc",
				textobject = "gc",
			},
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ mini.pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-surround
	{
		"kylechui/nvim-surround",
		keys = {
			"<C-g>s",
			"<C-g>S",
			"ys",
			"yss",
			{ "yS", mode = { "n", "v" } },
			"ySS",
			{ "S", mode = { "n", "v" } },
			"gS",
			"ds",
			"cs",
			"cS",
		},
		config = function(_, opts)
			require("nvim-surround").setup(opts)
		end,
	},
	-- }}}
	-- {{{ vim-illuminate
	{
		"RRethy/vim-illuminate",
		event = "LazyFile",
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	-- }}}
}
