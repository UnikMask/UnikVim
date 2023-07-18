-- Function applied when the LSP is attached to a buffer.



return {
    {
	"neovim/nvim-lspconfig",
	dependencies = {
	    {
		"williamboman/mason.nvim",
		build = ":MasonUpdate"
	    },
	    'williamboman/mason-lspconfig.nvim',
	    'j-hui/fidget.nvim',
	    'folke/neodev.nvim',
	    "hrsh7th/cmp-nvim-lsp",
	    'RRethy/vim-illuminate',
	},
    lazy = false,
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
		    'jdtls',
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
}
