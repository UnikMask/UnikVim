-- Setup lualine layout
return {
    {
        "nvim-lualine/lualine.nvim",
        event = 'BufEnter',
        config = function()
            require("lualine").setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = '|',
                    section_separators = { left = ' ', right = ' ' },
                },
                sections = {
                    lualine_a = {
                        { 'mode', separator = { left = ' ' }, right_padding = 2, }
                    },
                    lualine_b = { 'filename', 'branch' },
                    lualine_c = { 'fileformat' },
                    lualine_x = {
                        {
                            'diagnostics',
                            sources = { 'nvim_diagnostic', 'coc' },
                            symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌶 ' },
                            colored = true,
                            update_in_insert = true,
                            always_visible = false,
                        },
                    },
                    lualine_y = { 'filetype', 'progress' },
                    lualine_z = {
                        { 'location', separator = { right = ' ' }, left_padding = 2 },
                    },
                },
                inactive_sections = {
                    lualine_a = {
                        { 'filename', separator = { left = ' ', right = ' ' } }
                    },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {
                        { 'location', separator = { left = ' ', right = ' ' } },
                    },
                },
                tabline = {},
                extensions = {},
            }
        end
    },
    {
        'romgrk/barbar.nvim',
        lazy = true,
        event = 'VeryLazy',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            animation = true,
            auto_hide = true,
            separator = { left = '▎', right = '' },
            icons = {
                button = '',
            },
        },
        init = function() vim.g.barbar_auto_setup = false end,
        config = function(_, opts)
            require('barbar').setup(opts)
            require('keymaps.barbar')
        end,
    },
    {
        'stevearc/dressing.nvim',
        lazy = true,
        event = 'VeryLazy',
        opts = {},
    },
    {
        "j-hui/fidget.nvim",
        lazy = true,
        opts = {},
    },
}
