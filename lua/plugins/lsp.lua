return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = "BufRead",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
            "lukas-reineke/lsp-format.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "folke/trouble.nvim",
            "nvimtools/none-ls.nvim",
            "ray-x/lsp_signature.nvim",
            "folke/neodev.nvim",
        },
        config = function()
            -- Set up LSP format wrapper
            require("lsp-format").setup()
            local lspconfigs = require("opts.lsp").lspconfig()
            local disabled = require("opts.lsp").lspconfig_disable
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    if lspconfigs[server_name] ~= nil then
                        require("lspconfig")[server_name].setup(lspconfigs[server_name])
                    elseif disabled[server_name] == true then
                        require("lspconfig")[server_name].setup({})
                    end
                end
            }
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        lazy = true,
        ft = { "rust" },
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("rust-tools").setup(require("opts.lsp")["rust"]())
        end
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
        end
    },
}
