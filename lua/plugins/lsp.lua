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
	    {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            dependencies = {
                "rcarriga/nvim-notify",
            }
        },
	    'folke/neodev.nvim',
	    "hrsh7th/cmp-nvim-lsp",
	},
	config = function()
	    require('mason').setup()

	    require('fidget').setup()
	    require('neodev').setup()

	    require('mason-lspconfig').setup {
            ensure_installed = {
                'lua_ls',
                --'rust_analyzer',
                'clangd',
                'cmake',
                --'dockerls',
                --'eslint',
                --'gopls',
                --'jdtls',
                'pylsp',
            },
            automatic_installation = true,
	    }

	    -- Get client capabilities, and add cmp-nvim-lsp's capabilities.
	    local capabilities = vim.lsp.protocol.make_client_capabilities()
	    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	    -- Language-wise configuration
	    local lspconfig = require('lspconfig')
	    lspconfig["lua_ls"].setup({
		capabilities = capabilities,
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
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
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
