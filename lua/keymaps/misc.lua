local misc = {}

-- Neogit setup
misc.neogit = {
    {
        "<leader>gg",
        function()
            require("neogit").open()
        end,
        desc = "Open Git",
    },
}

-- Fugitive Setup
misc.gitsigns = {
    {
        "<leader>gb",
        function()
            vim.cmd("Gitsigns toggle_current_line_blame")
        end,
        desc = "Git Blame",
    },
}

-- Nvim-tree setup
misc.nvimtree = {
    {
        "<leader>et",
        function()
            require("nvim-tree.api").tree.toggle()
        end,
        desc = "File Explorer tree",
    },
}

-- Auto-session setup
misc.auto_session = {
    {
        "<leader>ql",
        function()
            require("auto-session").RestoreSession()
        end,
        desc = "Restore last session",
    },
}

-- Lazy.nvim setup
local lazy = require("lazy")
misc.lazy = {
    { "<leader>Ll", lazy.home,    desc = "Lazy home" },
    { "<leader>Lp", lazy.profile, desc = "Lazy home" },
    { "<leader>Lh", lazy.health,  desc = "Healthcheck" },
    { "<leader>LH", lazy.help,    desc = "Help page" },
    { "<leader>Ld", lazy.debug,   desc = "Debug info" },
}

-- Orgmode setup
misc.orgmode = {
    {
        "<leader>oa",
        function()
            require("orgmode").action("agenda.prompt", { opts = { buffer = false } })
        end,
        desc = "Org agenda",
    },
    {
        "<leader>oc",
        function()
            require("orgmode").action("capture.prompt", { opts = { buffer = false } })
        end,
        desc = "Org capture",
    },
}

misc.notify = {
    {
        "<leader>nh",
        function()
            vim.cmd("Notifications")
        end,
        desc = "History",
    },
}

-- Overseer keymaps

misc.overseer = {
    {
        "<leader>to",
        function()
            require("overseer").toggle()
        end,
        desc = "Toggle Window",
    },
    {
        "<leader>tt",
        function()
            require("overseer").run_template()
        end,
        desc = "Run Template",
    },
    {
        "<leader>ta",
        function()
            vim.cmd("OverseerQuickAction")
        end,
        "Run Quick Action",
    },
}

-- Leetbuddy keymaps
misc.leetbuddy = {
    {
        "<leader>ll",
        function()
            local opts = require("leetbuddy").user_config
            require("leetbuddy.questions").questions(opts)
        end,
        desc = "List Questions",
    },
    {
        "<leader>lq",
        function()
            local opts = require("leetbuddy").user_config
            require("leetbuddy.question").question(opts)
        end,
        desc = "Show Question",
    },
    {
        "<leader>lR",
        function()
            local opts = require("leetbuddy").user_config
            require("leetbuddy.reset").reset(opts)
        end,
        desc = "Reset buffer",
    },
    {
        "<leader>ls",
        function()
            local opts = require("leetbuddy").user_config
            require("leetbuddy.split").close_split(opts)
        end,
        desc = "Open split",
    },
    {
        "<leader>lk",
        function()
            local opts = require("leetbuddy").user_config
            require("leetbuddy.split").close_split(opts)
        end,
        desc = "Close split",
    },
    {
        "<leader>lt",
        function()
            local opts = require("leetbuddy").user_config
            require("leetbuddy.runner").test(opts)
        end,
        desc = "Test code",
    },
    {
        "<leader>lr",
        function()
            local opts = require("leetbuddy").user_config
            require("leetbuddy.runner").submit(opts)
        end,
        desc = "Submit code",
    },
    {
        "<leader>lA",
        function()
            local opts = require("leetbuddy").user_config
            require("leetbuddy.cookies").check_auth(opts)
        end,
        desc = "Check authentication",
    },
}

-- Nvim-Spider
misc.nvimSpider = {
    {
        "w",
        function()
            require("spider").motion("w")
        end,
        desc = "Next word",
        mode = { "n", "v" },
    },
    {
        "e",
        function()
            require("spider").motion("e")
        end,
        desc = "Next end of word",
        mode = { "n", "v" },
    },
    {
        "b",
        function()
            require("spider").motion("b")
        end,
        desc = "Previous word",
        mode = { "n", "v" },
    },
}

-- Tagbar Setup
misc.tagbar = {
    {
        "<leader>er",
        function()
            require("lazy").load({ plugins = { "tagbar" } })
            vim.cmd("TagbarToggle")
        end,
        "Toggle tags",
    },
}

return misc
