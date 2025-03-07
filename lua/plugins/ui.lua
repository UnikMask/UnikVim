-- Setup lualine layout
return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            local tagbar_extension = {
                sections = {
                    lualine_a = { function()
                        return "Tagbar"
                    end }
                },
                filetypes = { "tagbar" },
            }
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = "|",
                    section_separators = { left = " ", right = " " },
                },
                sections = {
                    lualine_a = {
                        { "mode", separator = { left = " " }, right_padding = 2 },
                    },
                    lualine_b = {
                        {
                            "filename",
                            symbols = {
                                modified = "",
                                readonly = "",
                                newfile = "󰎔",
                            },
                        },
                        "branch",
                    },
                    lualine_c = { "fileformat" },
                    lualine_x = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic", "nvim_workspace_diagnostic" },
                            symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
                            colored = true,
                            update_in_insert = true,
                            always_visible = false,
                        },
                    },
                    lualine_y = { "filetype", "progress" },
                    lualine_z = {
                        { "location", separator = { right = " " }, left_padding = 2 },
                    },
                },
                inactive_sections = {
                    lualine_a = {
                        {
                            "filename",
                            separator = { left = " ", right = " " },
                            symbols = {
                                modified = "",
                                readonly = "",
                                newfile = "󰎔",
                            },
                        },
                    },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic", "nvim_workspace_diagnostic" },
                            symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
                            colored = true,
                            update_in_insert = true,
                            always_visible = false,
                        },
                    },
                    lualine_y = {},
                    lualine_z = {
                        { "location", separator = { left = " ", right = " " } },
                    },
                },
                tabline = {},
                extensions = {
                    "quickfix",
                    "overseer",
                    "nvim-tree",
                    "lazy",
                    "mason",
                    "trouble",
                    "toggleterm",
                    tagbar_extension,
                },
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {},
    },
}
