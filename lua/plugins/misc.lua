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
}
