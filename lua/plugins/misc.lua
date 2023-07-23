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
}
