return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = {
			"rcarriga/nvim-notify",
			"nvim-lua/plenary.nvim",
			"ahmedkhalf/project.nvim",
			"rmagatti/auto-session",
			{ "brookhong/telescope-pathogen.nvim" },
			"tsakirist/telescope-lazy.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-file-browser.nvim",
		},
		lazy = true,
		cmd = { "Telescope" },
		init = function()
			require("keymaps.telescope")
		end,
		config = function()
			-- Load Telescope
			local telescope = require("telescope")
			telescope.setup({
                extensions = {
                    ["pathogen"] = {
                        theme = 'ivy',
                    },
                },
				pickers = {
					find_files = {
						theme = "ivy",
					},
				},
			})

			-- Setup extensions
			require("auto-session").setup_session_lens()

			-- Load Telescope extensions
			local load_extensions = function(extensions)
				for _, ext in pairs(extensions) do
					telescope.load_extension(ext)
				end
			end
			load_extensions({
				"lazy",
				"fzf",
				"file_browser",
				"projects",
				"notify",
				"session-lens",
				"pathogen",
			})
		end,
	},
}
