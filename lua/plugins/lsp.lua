return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"lukas-reineke/lsp-format.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"folke/trouble.nvim",
            "ray-x/lsp_signature.nvim",
		    "folke/neodev.nvim",
		},
		config = function()
			-- Set up LSP format wrapper
			require("lsp-format").setup()

			-- Load options from file
			for k, v in pairs(require("opts.lsp").lspconfig()) do
				require("lspconfig")[k].setup(v)
			end
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
		ft = { "java" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local start_java_lsp = function()
				require("jdtls").start_or_attach(require("opts.lsp")["jdtls"])
			end
			vim.api.nvim_create_autocmd("FileType java", {
				group = vim.api.nvim_create_augroup("NvimJDTLS", {}),
				callback = function()
					start_java_lsp()
				end,
			})
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
		"~p00f/clangd_extensions.nvim",
		lazy = true,
		ft = { "c", "cpp" },
		url = "https://git.sr.ht/~p00f/clangd_extensions.nvim/",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
        config = function()
            require("clangd_extensions").setup(require("opts.lsp")["clangd"]())
        end
	},
	{
		"folke/neodev.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		lazy = true,
		opts = {},
	},
	{
		"ray-x/lsp_signature.nvim",
		lazy = true,
		opts = {},
	},
	{
		"williamboman/mason.nvim",
		lazy = true,
		opts = require("opts.lsp")["mason"],
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		opts = require("opts.lsp")["mason_lspconfig"],
	},
	{
		"lukas-reineke/lsp-format.nvim",
		lazy = true,
		opts = {},
	},
}
