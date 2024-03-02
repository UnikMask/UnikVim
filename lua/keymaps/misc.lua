local wk = require("which-key")
local misc = {}
local prefix = { prefix = "<leader>" }

-- Neogit setup
misc.neogit = function()
    local neogit = function()
        return require("neogit")
    end
    wk.register({
        g = {
            name = "Git",
            g = {
                function()
                    neogit().open()
                end,
                "Git status",
            },
        },
    }, prefix)
end

-- Fugitive Setup
misc.gitsigns = function()
    local command = function(cmd)
        return function()
            require("lazy").load({ plugins = { "vim-fugitive" } })
            vim.cmd(cmd)
        end
    end
    wk.register({
        g = {
            b = {
                command("Gitsigns toggle_current_line_blame"),
                "Toggle Git blame",
            },
        },
    }, prefix)
end

-- Nvim-tree setup
misc.nvimtree = function()
    local api = function()
        return require("nvim-tree.api")
    end
    wk.register({
        e = {
            name = "Open",
            t = {
                function()
                    api().tree.toggle()
                end,
                "File Explorer tree",
            },
        },
    }, prefix)
end

-- Auto-session setup
misc.auto_session = function()
    local auto_session = function()
        return require("auto-session")
    end
    wk.register({
        q = {
            name = "Sessions",
            l = {
                function()
                    auto_session().RestoreSession()
                end,
                "Restore last session",
            },
        },
    }, prefix)
end

-- Lazy.nvim setup
misc.lazy = function()
    wk.register({
        L = {
            name = "Lazy",
            l = { require("lazy").home, "Lazy Home" },
            p = { require("lazy").profile, "Profile" },
            h = { require("lazy").health, "Healthcheck" },
            H = { require("lazy").help, "Help Page" },
            d = { require("lazy").debug, "Debug Info" },
        },
    }, prefix)
end

-- Orgmode setup
misc.orgmode = function()
    wk.register({
        o = {
            name = "Orgmode",
            a = {
                function()
                    require("orgmode").action("agenda.prompt", { opts = { buffer = false } })
                end,
                "org agenda",
            },
            c = {
                function()
                    require("orgmode").action("capture.prompt", { opts = { buffer = false } })
                end,
                "org capture",
            },
        },
    }, { prefix = "<leader>" })
end

misc.notify = function()
    wk.register({
        n = {
            name = "Notifications",
            h = {
                function()
                    vim.cmd("Notifications")
                end,
                "History",
            },
        },
    }, prefix)
end

-- Overseer keymaps

misc.overseer_init = function()
    wk.register({
        t = {
            name = "Tasks",
            o = {
                function()
                    require("overseer").toggle()
                end,
                "Toggle Window",
            },
            t = {
                function()
                    require("overseer").run_template()
                end,
                "Run Template",
            },
        },
    }, prefix)
end

misc.overseer_config = function()
    wk.register({
        a = {
            function()
                vim.cmd("OverseerQuickAction")
            end,
            "Run Quick Action",
        },
    }, { prefix = "<leader>t" })
end

-- Leetbuddy keymaps
misc.leetbuddy = function()
    wk.register({
        l = {
            name = "Leetbuddy",
            l = {
                function()
                    local opts = require("leetbuddy").user_config
                    require("leetbuddy.questions").questions(opts)
                end,
                "List Questions",
            },
            q = {
                function()
                    local opts = require("leetbuddy").user_config
                    require("leetbuddy.question").question(opts)
                end,
                "Show Question",
            },
            R = {
                function()
                    local opts = require("leetbuddy").user_config
                    require("leetbuddy.reset").reset(opts)
                end,
                "Reset buffer",
            },
            s = {
                function()
                    local opts = require("leetbuddy").user_config
                    require("leetbuddy.split").close_split(opts)
                end,
                "Open split",
            },
            k = {
                function()
                    local opts = require("leetbuddy").user_config
                    require("leetbuddy.split").close_split(opts)
                end,
                "Close split",
            },
            t = {
                function()
                    local opts = require("leetbuddy").user_config
                    require("leetbuddy.runner").test(opts)
                end,
                "Test code",
            },
            r = {
                function()
                    local opts = require("leetbuddy").user_config
                    require("leetbuddy.runner").submit(opts)
                end,
                "Submit code",
            },
            A = {
                function()
                    local opts = require("leetbuddy").user_config
                    require("leetbuddy.cookies").check_auth(opts)
                end,
                "Check authentication",
            },
        },
    }, prefix)
end

-- Nvim-Spider
misc.nvimSpider = function()
    wk.register({
        w = {
            function()
                require("spider").motion("w")
            end,
            "Next word",
        },
        e = {
            function()
                require("spider").motion("e")
            end,
            "Next end of word",
        },
        b = {
            function()
                require("spider").motion("b")
            end,
            "Previous word",
        },
    }, {
        prefix = "",
        mode = { "n", "v" },
    })
end

-- Tagbar Setup
misc.tagbar = function()
    wk.register({
        e = {
            r = {
                function()
                    require("lazy").load({ plugins = { "tagbar" } })
                    vim.cmd("TagbarToggle")
                end,
                "Toggle tags",
            },
        },
    }, prefix)
end

return misc
