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
        lazy = false,
        module = true,
        config = function() vim.notify = require('notify') end
    },
}
