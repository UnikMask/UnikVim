local opts = {}

local find_exec = function()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    return coroutine.create(function(coro)
        local telescope_opts = {}
        pickers
            .new(telescope_opts, {
                prompt_title = "Path to executable",
                finder = finders.new_oneshot_job({ "fd", "--no-ignore", "--type", "x" }, {}),
                sorter = conf.generic_sorter(telescope_opts),
                attach_mappings = function(buffer_number)
                    actions.select_default:replace(function()
                        actions.close(buffer_number)
                        coroutine.resume(coro, action_state.get_selected_entry()[1])
                    end)
                    return true
                end,
            })
            :find()
    end)
end


opts.dap = function()
    local c_configs = {
        {
            name = "Launch (gdb)",
            type = "gdb",
            request = "launch",
            program = find_exec,
            cwd = "${workspaceFolder}/build",
        },
        {
            name = 'Launch (lldb-vscode)',
            type = 'lldb',
            request = 'launch',
            program = find_exec,
            cwd = '${workspaceFolder}/build',
            stopOnEntry = false,
            args = {},
        },

    }
    return {
        configurations = {
            cpp = c_configs,
            c = c_configs
        },
        adapters = {
            gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            },
            lldb = {
                type = 'executable',
                command = '/usr/bin/lldb', -- adjust as needed, must be absolute path
                name = 'lldb'
            },
        }
    }
end

opts.dapui = {}
opts.mason = {
    ensure_installed = { "delve", "cppdbg" },
}

return opts
