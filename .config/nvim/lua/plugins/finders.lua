Constants = require("config.constants")
Customize = require("config.customize")
Is_Enabled = require("config.functions").is_enabled

return {
	-- {{{ Telescope
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				";l",
				"<cmd>Telescope neoclip<cr>",
			},
			{
				";f",
				function()
					require("telescope.builtin").find_files({ hidden = true })
				end,
			},
			{
				";g",
				function()
					require("telescope.builtin").git_commits()
				end,
			},
			{
				";r",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"\\\\",
				function()
					require("telescope.builtin").buffers()
				end,
			},
			{
				";t",
				function()
					require("telescope.builtin").help_tags()
				end,
			},
			{
				";;",
				function()
					require("telescope.builtin").resume()
				end,
			},
			{
				";e",
				function()
					require("telescope.builtin").diagnostics()
				end,
			},
			{
				";F",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find(
						require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
					)
				end,
			},
			{
				"sf",
				function()
					require("telescope").extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = vim.fn.expand("%:p:h"),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "normal",
						layout_config = { prompt_position = "top", height = 60 },
					})
				end,
			},
			{
				"<leader>LS",
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			},
			{
				"<leader>Ls",
				"<cmd>Telescope lsp_document_symbols<cr>",
			},
			{
				"gD",
				function()
					vim.lsp.buf.declaration()
				end,
				desc = "Goto Definition",
			},
			{
				"gd",
				"<Cmd>Telescope lsp_definitions<cr>",
				desc = "Goto Definition",
			},
			{
				"gr",
				"<Cmd>Telescope lsp_references<cr>",
				desc = "Goto Definition",
			},
			{
				"gI",
				"<Cmd>Telescope lsp_implementations<cr>",
				desc = "Goto Definition",
			},
			{
				"gK",
				"<Cmd>Telescope lsp_implementations<cr>",
				desc = "Goto Definition",
			},
			{
				"gt",
				"<Cmd>Telescope lsp_type_definitions<cr>",
				desc = "Goto Definition",
			},
		},
		enabled = Is_Enabled("telescope.nvim"),
		cmd = "Telescope",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"AcksLd/nvim-neoclip.lua",
		},
		opts = function()
			return {
				defaults = {
					layout_config = { prompt_position = "top" },
					layout_strategy = "horizontal",
					prompt_prefix = Constants.icons.ui.Telescope,
					sorting_strategy = "ascending",
					winblend = 0,

					keymaps = {
						["n"] = {
							["<esc>"] = require("telescope.actions").close,
						},
					},
				},
			}
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ Telescope file browser
	{
		"nvim-telescope/telescope-file-browser.nvim",
		enabled = Is_Enabled("telescope-file-browser.nvim"),
		dependencies = { "nvim-telescope/telescope.nvim" },
		--  cmd = "Telescope",
		config = function()
			local telescope = require("telescope")
			local fb_actions = require("telescope").extensions.file_browser.actions
			telescope.setup({
				extensions = {
					file_browser = {
						theme = "dropdown",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						mappings = {
							-- your custom insert mode mappings
							["i"] = {
								["<C-w>"] = function()
									vim.cmd("normal vbd")
								end,
							},
							["n"] = {
								-- your custom normal mode mappings
								["N"] = fb_actions.create,
								["h"] = fb_actions.goto_parent_dir,
								["/"] = function()
									vim.cmd("startinsert")
								end,
							},
						},
					},
				},
			})
			telescope.load_extension("file_browser")
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ neoclip.lua
	{
		"AcksLd/nvim-neoclip.lua",
		opts = {
			preview = true,
		},
		config = function(_, opts)
			require("neoclip").setup(opts)
		end,
	},
	-- }}}
}
