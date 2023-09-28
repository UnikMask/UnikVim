return {
    {
        "chrisbra/Colorizer",
        lazy = true,
        config = function()
            vim.g.colorizer_auto_color = true
            vim.g.colorizer_skip_comments = true
            vim.g.colorizer_disable_bufleave = true
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        lazy = true,
        opts = {},
    },
    {
        "rcarriga/nvim-notify",
        dependencies = {
            'UnikMask/iroh-vim',
        },
        lazy = true,
        event = 'VeryLazy',
        module = true,
        opts = {
            timeout = 100,
            fps = 60,
            top_down = true,
        },
        config = function(_, opts)
            require('notify').setup(opts)
            vim.notify = require('notify')
        end
    },
    {
        'folke/which-key.nvim',
        opts = {},
        lazy = true,
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },
    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        lazy = true,
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        lazy = true,
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = true,
		opts = {},
	},
    {
        "Dhanus3133/Leetbuddy.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        lazy = true,
        opts = {
            domain = "com",
            language = "py",
        },
        init = function ()
            require('keymaps.misc').leetbuddy()
        end
    }
}
