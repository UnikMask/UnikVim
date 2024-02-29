return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "rcarriga/nvim-notify",
        dependencies = {
            'UnikMask/iroh-vim',
        },
        lazy = true,
        event = 'VimEnter',
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
        lazy = false,
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },
    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = "BufRead",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        lazy = true,
        event = "InsertEnter",
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
        init = function()
            require('keymaps.misc').leetbuddy()
        end
    },
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        opts = {},
        init = function()
            require("keymaps.misc").nvimSpider()
        end,
    },
    {
        "preservim/tagbar",
        lazy = true,
        cmd = { "TagbarToggle" },
        init = function()
            require("keymaps.misc").tagbar()
        end
    }
}
