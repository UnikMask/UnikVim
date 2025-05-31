return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        lazy = true,
        keys = require("keymaps.dap"),
        config = function()
            local opts = require("opts.dap")

            local dap, dapui = require("dap"), require("dapui")

            -- Set up Mason installation
            require("mason-nvim-dap").setup(opts.mason)

            -- Set up DAP configurations
            for name, val in pairs(opts.dap().configurations) do
                require("dap").configurations[name] = val
            end
            for name, val in pairs(opts.dap().adapters) do
                require("dap").adapters[name] = val
            end

            -- Set up DAP UI
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
        end,
    },
}
