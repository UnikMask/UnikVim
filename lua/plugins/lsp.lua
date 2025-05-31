return {
    {
        "ray-x/lsp_signature.nvim",
        lazy = true,
        event = "InsertEnter",
        opts = {},
    },
    {
        "lukas-reineke/lsp-format.nvim",
        lazy = true,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = true,
        version = "2.0.0",
        event = "BufRead",
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },
            "neovim/nvim-lspconfig",
        },
        opts = {
            -- exclude = { "rust-analyzer" },
            ensure_installed = { "lua_ls" },
            automatic_enable = true,
        },
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
        ft = { "rust" },
        keys = {
            {
                "<leader>cT",
                function()
                    vim.cmd.RustLsp("testables")
                end,
            },
        },
    },
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        event = "BufRead",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                debug = false,
                sources = {
                    -- null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.stylua,
                    require("none-ls.diagnostics.eslint_d"),
                    require("none-ls.diagnostics.cpplint"),
                },
            })
        end,
    },
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = { "c", "cpp" },
        -- url = "https://git.sr.ht/~p00f/clangd_extensions.nvim/",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("clangd_extensions").setup(require("opts.lsp")["clangd"]())
            require("lspconfig")["clangd"].setup(require("opts.lsp")["lsp_clangd"]())
        end,
    },
    {
        "folke/lazydev.nvim",
        lazy = true,
        ft = "lua",
        opts = {
            integrations = {
                lspconfig = true,
                cmp = true,
            },
        },
    },
}
