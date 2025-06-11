-- Setup lualine layout
return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = "|",
				section_separators = { left = " ", right = " " },
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = " " }, right_padding = 2 },
				},
				lualine_b = {
					{
						"filename",
						symbols = {
							modified = "",
							readonly = "",
							newfile = "󰎔",
						},
					},
					"branch",
				},
				lualine_c = {
					{ "fileformat", separator = { right = "" } },
					{
						"diff",
						symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
					},
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_workspace_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
						colored = true,
						update_in_insert = true,
						always_visible = false,
					},
				},
				lualine_y = {
					"filetype",
					"progress",
				},
				lualine_z = {
					{ "location", separator = { right = " " }, left_padding = 2 },
				},
			},
			inactive_sections = {
				lualine_a = {
					{
						"filename",
						separator = { left = " ", right = " " },
						symbols = {
							modified = "",
							readonly = "",
							newfile = "󰎔",
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {
					{ "location", separator = { left = " ", right = " " } },
				},
			},
			tabline = {},
			filetypes = {},
			extensions = {
				"quickfix",
				"overseer",
				"nvim-tree",
				"lazy",
				"mason",
				"trouble",
				"toggleterm",
			},
		},
		config = function(_, opts)
			local trouble = require("trouble")
			local symbols = trouble.statusline({
				mode = "diagnostics",
				groups = {},
				title = false,
				filter = { range = true },
				format = "{kind_icon}{symbol.name:Normal}",
				-- The following line is needed to fix the background color
				-- Set it to the lualine section you want to use
				hl_group = "lualine_c_normal",
			})
			table.insert(opts.sections.lualine_x, {
				symbols.get,
				cond = symbols.has,
			})
			table.insert(opts.filetypes, "tagbar")
			require("lualine").setup(opts)
		end,
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
		lazy = true,
		event = "BufRead",
		opts = {
			-- options
		},
	},
}
