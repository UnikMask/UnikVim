return {
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        dependencies = {
            { 'nvim-tree/nvim-web-devicons' }
        },
        opts = {
            theme = 'doom',
            shortcut_type = 'letter',
            hide = { 'statusline', 'tabline', 'winbar' },
            config = {
                header = {
                    '',
                    '',
                    '',
                    '',
                    '         ___           ___                       ___           ___                       ___      ',
                    '        /\\__\\         /\\__\\          ___        /\\__\\         /\\__\\          ___        /\\__\\     ',
                    '       /:/  /        /::|  |        /\\  \\      /:/  /        /:/  /         /\\  \\      /::|  |    ',
                    '      /:/  /        /:|:|  |        \\:\\  \\    /:/__/        /:/  /          \\:\\  \\    /:|:|  |    ',
                    '     /:/  /  ___   /:/|:|  |__      /::\\__\\  /::\\__\\____   /:/__/  ___      /::\\__\\  /:/|:|__|__  ',
                    '    /:/__/  /\\__\\ /:/ |:| /\\__\\  __/:/\\/__/ /:/\\:::::\\__\\  |:|  | /\\__\\  __/:/\\/__/ /:/ |::::\\__\\ ',
                    '    \\:\\  \\ /:/  / \\/__|:|/:/  / /\\/:/  /    \\/_|:|~~|~     |:|  |/:/  / /\\/:/  /    \\/__/~~/:/  / ',
                    '     \\:\\  /:/  /      |:/:/  /  \\::/__/        |:|  |      |:|__/:/  /  \\::/__/           /:/  /  ',
                    '      \\:\\/:/  /       |::/  /    \\:\\__\\        |:|  |       \\::::/__/    \\:\\__\\          /:/  /   ',
                    '       \\::/  /        /:/  /      \\/__/        |:|  |        ~~~~         \\/__/         /:/  /    ',
                    '        \\/__/         \\/__/                     \\|__|                                   \\/__/     ',
                    '',
                    '////////////////////////////',
                    '// B Y    U N I K M A S K //',
                    '////////////////////////////',
                    '',
                    '',
                    '',
                    '',
                },
                center = {
                    {
                        icon = ' ',
                        desc = 'Reload Last Session',
                        key = 'q',
                        action = function()
                            require('auto-session').RestoreSession()
                        end,
                    },
                    {
                        icon = ' ',
                        desc = 'Recently opened files',
                        key = 'r',
                        action = function()
                            require('telescope.builtin').oldfiles()
                        end,
                    },
                    {
                        icon = '󰈞 ',
                        desc = 'Find file',
                        key = 'f',
                        action = function()
                            require('telescope.builtin').find_files()
                        end,
                    },
                    {
                        icon = ' ',
                        desc = 'Open project',
                        key = 'p',
                        action = function()
                            require("telescope").extensions.projects.projects()
                        end,
                    },
                    {
                        icon = ' ',
                        desc = 'Open private configuration',
                        key = 'd',
                        action = function()
                            require('telescope.builtin').find_files({
                                cwd = vim.api.nvim_list_runtime_paths()[1]
                            })
                        end
                    },
                },
                footer = function()
                    local stats = require('lazy').stats()
                    return { '', '', stats.count
                    .. ' packages loaded in '
                    .. string.format('%.3f', stats.startuptime)
                    .. ' milliseconds.' }
                end,
            },
        },
    }
}
