return {
    {
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      config = function()
	require('dashboard').setup {
	    theme = 'doom',
	    shortcut_type = 'letter',
	    hide = {'statusline', 'tabline', 'winbar'},
	    config = {
		header = {
		    '',
		    '',
		    '',
		    '',
		'         ___           ___                       ___           ___                       ___      ',
		'        /\\__\\         /\\__\\          ___        /\\__\\         /\\__\\          ___        /\\__\\     ',
		'       /:/  /        /::|  |        /\\  \\      /:/  /        /:/  /         /\\  \\      /::|  |    ',
		'      /:/  /        /:|:|  |        \\:\\  \\    /:/__/        /:/  /          \\:\\  \\    /:|:|  |    ',
		'     /:/  /  ___   /:/|:|  |__      /::\\__\\  /::\\__\\____   /:/__/  ___      /::\\__\\  /:/|:|__|__  ',
		'    /:/__/  /\\__\\ /:/ |:| /\\__\\  __/:/\\/__/ /:/\\:::::\\__\\  |:|  | /\\__\\  __/:/\\/__/ /:/ |::::\\__\\ ',
		'    \\:\\  \\ /:/  / \\/__|:|/:/  / /\\/:/  /    \\/_|:|~~|~     |:|  |/:/  / /\\/:/  /    \\/__/~~/:/  / ',
		'     \\:\\  /:/  /      |:/:/  /  \\::/__/        |:|  |      |:|__/:/  /  \\::/__/           /:/  /  ',
		'      \\:\\/:/  /       |::/  /    \\:\\__\\        |:|  |       \\::::/__/    \\:\\__\\          /:/  /   ',
		'       \\::/  /        /:/  /      \\/__/        |:|  |        ~~~~         \\/__/         /:/  /    ',
		'        \\/__/         \\/__/                     \\|__|                                   \\/__/     ',
		    '',
		    '////////////////////////////',
		    '// B Y    U N I K M A S K //',
		    '////////////////////////////',
		    '',
		    '',
		    '',
		    '',
		},
		center = {
		    {
			icon = ' ',
			desc = 'Reload Last Session',
			key = 'q',
			action = 'lua print(0)'
		    },
		    {
			icon =  ' ',
			desc = 'Recently opened files',
			key = 'r',
			action = 'lua require(\'telescope.builtin\').oldfiles()',
		    },
		    {
			icon =  '󰈞 ',
			desc = 'Find file',
			key = 'f',
			action = 'lua require(\'telescope.builtin\').find_files()',
		    },
		    {
			icon =  ' ',
			desc = 'Open project',
			key = 'p',
			action = 'lua require("telescope").extensions.projects.projects{}',
		    },
		    {
			icon =  ' ',
			desc = 'Open private configuration',
			key = 'd',
			action = 'lua require(\'telescope.builtin\').find_files({cwd=\'~/.config/nvim\'})',
		    },
		}
	    }
	}
      end,
      dependencies = { {'nvim-tree/nvim-web-devicons'}}
    }
}
