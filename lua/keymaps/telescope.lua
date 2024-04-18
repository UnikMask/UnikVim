-- Telescope keymaps
-- Loaded during config upon loading telescope

local wk = require("which-key")
local bt = function()
    return require("telescope.builtin")
end
local sfp_arg = function()
    return {
        cwd = vim.api.nvim_list_runtime_paths()[1],
        hidden = true,
    }
end

local man_pages_nums = { name = "Man pages" }
for i = 1, 8 do
    man_pages_nums[tostring(i)] = {
        function()
            bt().man_pages({ sections = { tostring(i) } })
        end,
        "Section " .. tostring(i)
    }
end

wk.register({
    x = {
        function()
            bt().commands()
        end,
        "Show commands"
    },
    T = {
        function()
            bt().builtin()
        end,
        "Telescope Builtins"
    },
    h = {
        name = "Help",
        h = {
            function()
                bt().help_tags()
            end,
            "Neovim Help Tags",

        },
        M = {
            function()
                bt().man_pages({ sections = { "ALL" } })
            end,
            "All man Pages"
        },
        m = man_pages_nums
    },
    f = {
        name = "Find",
        f = {
            function()
                bt().find_files({ hidden = false })
            end,
            "Files in Directory",
        },
        F = {
            function()
                bt().find_files({ hidden = true })
            end,
            "File Picker",
        },
        ["~"] = {
            function()
                bt().find_files({
                    cwd = "~",
                    hidden = true,
                })
            end,
            "Files in Home Directory",
        },
        p = {
            function()
                bt().find_files(sfp_arg())
            end,
            "Files in config",
        },
        g = {
            function()
                bt().live_grep()
            end,
            "String in document",
        },
        t = {
            function()
                bt().tags()
            end,
            "Project tags",
        },
        b = {
            function()
                bt().buffers()
            end,
            "Buffers",
        },
        r = {
            function()
                bt().oldfiles()
            end,
            "Recent files",
        },
        w = {
            function()
                require("telescope").extensions.projects.projects({})
            end,
            "Project",
        },
        s = {
            function()
                require("telescope")
                require("auto-session.session-lens").search_session()
            end,
            "Sessions",
        },
        R = {
            function()
                bt().registers({})
            end,
            "Registers"
        },
        c = {
            function()
                bt().colorscheme({})
            end,
            "Select Colorscheme",
        },
    },
}, { prefix = "<leader>" })
