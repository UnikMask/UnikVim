-- Function applied when the LSP is attached to a buffer.
local lspconfig_ls = { "lua_ls", "cmake", "pylsp", "gopls", "jsonls" }

local capabilities = nil
local get_capabilities = function()
    if capabilities == nil then
        capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
    end
    return capabilities
end

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
			"folke/neodev.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"folke/trouble.nvim",
		},
		config = function()
			-- Setup dependencies
			require("mason").setup()
			require("fidget").setup()
			require("neodev").setup()

			-- Setup Mason module
			require("mason-lspconfig").setup({
				ensure_installed = lspconfig_ls,
				automatic_installation = true,
			})

			-- Set up LSP format wrapper
			require("lsp-format").setup()

			-- Language-wise configuration
			local ls_config = {}
			local lspconfig = require("lspconfig")
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
						capabilities = get_capabilities(),
						on_attach = function(client)
							require("lsp-format").on_attach(client)
						end,
					}
				else
					ls_config[ls].capabilities = get_capabilities()
				end
				lspconfig[ls].setup(ls_config[ls])
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
		opts = {
			cmd = { "jdtls" },
			root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
		},
		config = function(_, opts)
			-- Set up dependencies
			require("fidget").setup()

			local start_java_lsp = function()
				require("jdtls").start_or_attach(opts)
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
		opts = {
			server = {
				capabilities = get_capabilities(),
			},
		},
	},
	{
		"~p00f/clangd_extensions.nvim",
		lazy = true,
		ft = { "c", "cpp" },
		url = "https://git.sr.ht/~p00f/clangd_extensions.nvim/",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		opts = {
			server = {
				capabilities = get_capabilities(),
			},
			ast = {
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
				},

				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"j-hui/fidget.nvim",
		},
		ft = { "lua" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
				},
			})
		end,
	},
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
}
