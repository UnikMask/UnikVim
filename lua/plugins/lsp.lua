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
            -- Functions for LSP server set up
            local capabilities
            local get_capabilities = function()
                if capabilities == nil then
                    capabilities =
                        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
                    capabilities.offsetEncoding = "utf-8"
                    capabilities.textDocument.semanticHighlighting = true
                end
                return capabilities
            end

            local on_attach = function(client, bufnr)
                return require("lsp-format").on_attach(client, bufnr)
            end

            -- Set up LSP format wrapper
            require("lsp-format").setup()
            local lspconfigs = require("opts.lsp").lspconfig()
            local disabled = require("opts.lsp").lspconfig_disable
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    if lspconfigs[server_name] ~= nil then
                        require("lspconfig")[server_name].setup(lspconfigs[server_name])
                    elseif disabled[server_name] == true then
                        -- require("lspconfig")[server_name].setup({})
                    else
                        require("lspconfig")[server_name].setup({
                            on_attach = on_attach,
                            capabilities = get_capabilities(),
                        })
                    end
                end,
            })
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = true,
        ft = { "rust" },
        keys = {
            {
                "<leader>cT",
                function()
                    vim.cmd.RustLsp("testables")
                end,
            },
        },
        init = function()
            vim.g.rustaceanvim = {
                tools = {},
                server = require("opts.lsp")["rust"](),
                dap = require("opts.dap")["rustaceanvim"](),
            }
        end,
    },
    {
        "nvimtools/none-ls.nvim",
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
}
