return {
    {
        "tpope/vim-fugitive",
        opts={},
        lazy = false,
        config = function()
        end
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
          'lewis6991/gitsigns.nvim',
          'nvim-tree/nvim-web-devicons',
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        config = function()
            require('barbar').setup({
            animation = true,
            auto_hide = true,
            separator = {left = '▎', right = ''},
            icons = {
                button = '',
            },
            })
        end,
        opts = {},
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
            ensure_installed = {'lua', 'c', 'java', 'python', 'vim', 'vimdoc', 'rust', 'cpp', 'cmake'},
            auto_install = true,
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            }
        end
    },
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
	require("nvim-tree").setup {
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
		    enable = true,
		    update_root = true
		},
	    }
      end,
    },
    {
	'ahmedkhalf/project.nvim',
	dependencies = {
	    'nvim-telescope/telescope.nvim',
	},
    lazy = false,
	config = function()
	    require("project_nvim").setup {}
	    require('telescope').load_extension('projects')
	end
    },
}
