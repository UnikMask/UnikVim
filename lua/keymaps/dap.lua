local wk = require("which-key")
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

return function()
	wk.register({
		d = {
			name = "Debugger",
			b = {
				function()
					dap().toggle_breakpoint()
				end,
				"Toggle breakpoint",
			},
			B = {
				function()
					dap().set_breakpoint()
				end,
				"Set breakpoint",
			},
			lp = {
				function()
					dap().set_breakpoint(nil, nil, vim.fn.input("Log point image: "))
				end,
				"Set log point",
			},
			j = {
				function()
					require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
				end,
				"Load launch.json",
			},
			d = {
				name = "Run",
				r = {
					function()
						dap().repl_open()
					end,
					"REPL",
				},
				l = {
					function()
						dap().repl_open()
					end,
					"Last configuration",
				},
				n = {
					function()
						dap().continue()
					end,
					"Run new configuration",
				},
			},
			n = {
				function()
					dap().step_over()
				end,
				"Step Over",
			},
			p = {
				function()
					dap().step_back()
				end,
				"Step Back",
			},
			i = {
				function()
					dap().step_into()
				end,
				"Step Into",
			},
			h = {
				function()
					widgets().hover(widgets().frames)
				end,
				"Show Hover",
			},
			f = {
				function()
					show_widget(widgets().scopes)
				end,
				"Show Frames",
			},
			s = {
				function()
					show_widget(widgets().scopes)
				end,
				"Show Scopes",
			},
            e = {
                function ()
                    ui().close()
                    dap().terminate()
                end, "End session and close UI"
            },
            c = {
                function ()
                    dap().continue()
                end, "Continue"
            },
            t = {
                function ()
                    dap().terminate()
                end, "Terminate Session"
            },
            o = {
                function ()
                    dap().toggle()
                end, "Toggle UI",
            },
		},
	}, { prefix = "<leader>" })
end
