return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		opts = {
			configs = {
				python = {
					{
						type = "python",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						pythonPath = function()
							return "/usr/bin/python"
						end,
					},
				},
			},
			dapui = {},
			mason = {
				ensure_installed = { "python", "cpptools", "stylua" },
				automatic_installation = true,
				handlers = {},
			},
		},
		lazy = true,
		init = function()
			require("keymaps.dap")()
		end,
		config = function(_, opts)
			-- Set up Mason installation
			require("mason-nvim-dap").setup(opts.mason)

			-- Set up DAP UI
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup(opts.dapui)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
			require("neodev").setup()

			-- Set up DAP configurations
			for name, val in pairs(opts.configs) do
				require("dap").configurations[name] = val
			end
		end,
	},
}
