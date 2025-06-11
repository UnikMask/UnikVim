return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"rcarriga/nvim-notify",
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		lazy = true,
		cmd = { "Telescope" },
		keys = require("keymaps.telescope"),
		config = function()
			-- Load Telescope
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
				pickers = {
					find_files = {
						theme = "ivy",
					},
				},
			})

			-- Load Telescope extensions
			local load_extensions = function(extensions)
				for _, ext in pairs(extensions) do
					telescope.load_extension(ext)
				end
			end
			load_extensions({
				"fzf",
				"notify",
				"session-lens",
			})
		end,
	},
}
