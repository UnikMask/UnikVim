-- Function applied when the LSP is attached to a buffer.



return {
    {
	"neovim/nvim-lspconfig",
    lazy = true,
    ft = {
        'c', 'cpp', 'lua', 'python', 'cmake',
        'rust', 'docker', 'javascript', 'typescript'},
	dependencies = {
	    {
            "williamboman/mason.nvim",
            build = ":MasonUpdate"
	    },
	    'williamboman/mason-lspconfig.nvim',
        'j-hui/fidget.nvim',
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
            ensure_installed = { 'lua_ls', 'clangd', 'cmake', 'pylsp'},
            automatic_installation = true,
	    }

	    -- Get client capabilities, and add cmp-nvim-lsp's capabilities.
	    local capabilities = vim.lsp.protocol.make_client_capabilities()
	    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	    -- Language-wise configuration
	    local lspconfig = require('lspconfig')
	    lspconfig["lua_ls"].setup({
            capabilities = capabilities,
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
	    })
	    lspconfig["pylsp"].setup({
            capabilities = capabilities,
	    })
	    lspconfig["clangd"].setup({
            capabilities = capabilities,
	    })
	    lspconfig["cmake"].setup({
            capabilities = capabilities,
	    })
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
            cmd = {'jdtls'},
            root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
        },
        config = function(_, opts)
            -- Set up dependencies
	        require('fidget').setup()

            local start_java_lsp = function()
                require('jdtls').start_or_attach(opts)
            end
            vim.api.nvim_create_autocmd('FileType java', {
                group = vim.api.nvim_create_augroup('NvimJDTLS', {}),
                callback = function ()
                    start_java_lsp()
                end
            })
        end
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        lazy = true,
        opts = {},
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
    }
}
