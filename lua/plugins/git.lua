return {
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'ahmedkhalf/project.nvim',
        },
        lazy = true,
        cmd = { 'Neogit' },
        init = function()
            require('keymaps.misc').neogit()
        end,
        opts = {
            kind = 'split_above',
            popup = {
                kind = 'split_above',
            },
            disable_builtin_notifications = true,
            integrations = {
                telescope = true,
            }
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            signcolumn = true,
        },
    }
}
