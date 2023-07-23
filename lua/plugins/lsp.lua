-- Function applied when the LSP is attached to a buffer.
local lspconfig_ls = { 'lua_ls', 'clangd', 'cmake', 'pylsp' }
local ts_supported_langs = {
    'lua', 'c', 'java', 'python', 'vim', 'vimdoc',
    'rust', 'cpp', 'cmake', 'org', 'html', 'latex',
}


return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        ft = {
            'c', 'cpp', 'lua', 'python', 'cmake',
            'rust', 'docker', 'javascript', 'typescript' },
        dependencies = {
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate"
            },
            'williamboman/mason-lspconfig.nvim',
            'j-hui/fidget.nvim',
            'lukas-reineke/lsp-format.nvim',
            'folke/neodev.nvim',
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- Setup dependencies
            require('mason').setup()
            require('fidget').setup()
            require('neodev').setup()

            -- Setup Mason module
            require('mason-lspconfig').setup {
                ensure_installed = { 'lua_ls', 'clangd', 'cmake', 'pylsp' },
                automatic_installation = true,
            }

            -- Set up LSP format wrapper
            require('lsp-format').setup()

            -- Get client capabilities, and add cmp-nvim-lsp's capabilities.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            -- Language-wise configuration
            local ls_config = {}
            local lspconfig = require('lspconfig')
            ls_config["lua_ls"] = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            }

            -- Load all configurations with cmp capabilities
            for _, ls in pairs(lspconfig_ls) do
                if ls_config[ls] == nil then
                    ls_config[ls] = {
                        capabilities = capabilities,
                        on_attach = function(client)
                            require("lsp-format").on_attach(client)
                        end
                    }
                else
                    ls_config[ls].capabilities = capabilities
                end
                lspconfig[ls].setup(ls_config[ls])
            end
        end
    },
    {
        'mfussenegger/nvim-jdtls',
        lazy = true,
        ft = { 'java' },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "neovim/nvim-lspconfig",
        },
        opts = {
            cmd = { 'jdtls' },
            root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
        },
        config = function(_, opts)
            -- Set up dependencies
            require('fidget').setup()

            local start_java_lsp = function()
                require('jdtls').start_or_attach(opts)
            end
            vim.api.nvim_create_autocmd('FileType java', {
                group = vim.api.nvim_create_augroup('NvimJDTLS', {}),
                callback = function()
                    start_java_lsp()
                end
            })
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            'j-hui/fidget.nvim',
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.clang_format,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                },
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'RRethy/vim-illuminate',
        },
        lazy = true,
        ft = ts_supported_langs,
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = ts_supported_langs,
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
            }
        end
    },
}
