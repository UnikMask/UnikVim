return {
	{
		"NeogitOrg/neogit",
		version = "2.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
		},
		lazy = true,
		cmd = { "Neogit" },
		keys = require("keymaps.misc").neogit,
		opts = {
			kind = "split_above",
			popup = {
				kind = "split_above",
			},
			disable_builtin_notifications = true,
			integrations = {
				telescope = true,
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufRead",
		keys = require("keymaps.misc").gitsigns,
		opts = {
			signcolumn = true,
			current_line_blame_opts = {
				delay = 50,
			},
		},
	},
}
