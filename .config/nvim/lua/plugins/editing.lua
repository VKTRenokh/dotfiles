return {
	-- {{{ nvim-autopairs
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
			{ "yS", mode = { "n", "v", "x" } },
			"ySS",
			{ "S", mode = { "n", "v", "x" } },
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
}
