-- Telescope keymaps
-- Loaded during config upon loading telescope

local wk = require("which-key")
local bt = function()
	return require("telescope.builtin")
end
local sfp_arg = function()
	return {
		cwd = vim.api.nvim_list_runtime_paths()[1],
		hidden = true,
	}
end

wk.register({
	f = {
		name = "Find",
		f = {
			function()
				require("telescope").extensions.pathogen.find_files({hidden = true})
			end,
			"Files in Directory",
		},
		p = {
			function()
				bt().find_files(sfp_arg())
			end,
			"Files in config",
		},
		g = {
			function()
				bt().live_grep()
			end,
			"String in document",
		},
		b = {
			function()
				bt().buffers()
			end,
			"Buffers",
		},
		h = {
			function()
				bt().help_tags()
			end,
			"Help tags",
		},
		r = {
			function()
				bt().oldfiles()
			end,
			"Recent files",
		},
		w = {
			function()
				require("telescope").extensions.projects.projects({})
			end,
			"Project",
		},
		s = {
			function()
				require("telescope")
				require("auto-session.session-lens").search_session()
			end,
			"Sessions",
		},
	},
}, { prefix = "<leader>" })
