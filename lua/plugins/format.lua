return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "RRethy/vim-illuminate",
            "folke/todo-comments.nvim",
        },
        lazy = true,
        event = "VeryLazy",
        opts = {
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
        },
        config = function(_, opts)
            vim.o.foldmethod = "expr"
            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "j-hui/fidget.nvim",
        },
        event = "VeryLazy",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.code_actions.gitsigns,
                    null_ls.builtins.completion.luasnip,
                    null_ls.builtins.completion.spell,
                },
            })
        end,
    },
    {
        "udalov/kotlin-vim",
        event = "VeryLazy",
    }
}
