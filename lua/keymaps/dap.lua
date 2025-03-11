local dap = function()
    return require("dap")
end
local ui = function()
    return require("dap")
end
local widgets = function()
    return require("dap.ui.widgets")
end
local show_widget = function(i)
    return widgets().centered_float(i)
end

return {
    {
        "<leader>db",
        function()
            dap().toggle_breakpoint()
        end,
        desc = "Toggle breakpoing",
    },
    {
        "<leader>dB",
        function()
            dap().set_breakpoint()
        end,
        desc = "Set breakpoint",
    },
    {
        "<leader>dlP",
        function()
            dap().set_breakpoint(nil, nil, vim.fn.input("Log point image: "))
        end,
        desc = "Set log point",
    },
    {
        "<leader>dJ",
        function()
            require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
        end,
        desc = "Load launch.json",
    },
    {
        "<leader>ddn",
        function()
            dap().continue()
        end,
        desc = "Run new configuration",
    },
    {
        "<leader>ddr",
        function()
            require("dap").repl.open()
        end,
        desc = "Open REPL",
    },
    {
        "<leader>dn",
        function()
            dap().step_over()
        end,
        desc = "Step Over",
    },
    {
        "<leader>dp",
        function()
            dap().step_back()
        end,
        desc = "Step Back",
    },
    {
        "<leader>di",
        function()
            dap().step_into()
        end,
        desc = "Step Into",
    },
    {
        "<leader>dwf",
        function()
            show_widget(widgets().frames)
        end,
        desc = "Show Frames",
    },
    {
        "<leader>dws",
        function()
            show_widget(widgets().scopes)
        end,
        desc = "Show Scopes",
    },
    {
        "<leader>dwe",
        function()
            show_widget(widgets().expressions)
        end,
        desc = "Show Expressions",
    },
    {
        "<leader>de",
        function()
            ui().close()
            dap().terminate()
        end,
        desc = "End session and close UI",
    },
    {
        "<leader>dc",
        function()
            dap().continue()
        end,
        desc = "Continue",
    },
    {
        "<leader>dt",
        function()
            dap().terminate()
        end,
        desc = "Terminate Session",
    },
    {
        "<leader>do",
        function()
            dap().toggle()
        end,
        desc = "Toggle UI",
    },
}
