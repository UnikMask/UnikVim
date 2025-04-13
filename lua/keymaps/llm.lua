return {
    {
        '<leader>aa',
        function()
            require("avante.api").ask()
        end,
        desc = "Prompt about code",
        mode = { "n", "v" }
    },
    {
        '<leader>ar',
        function()
            require("avante.api").refresh()
        end,
        desc = "Refresh prompt",
        mode = { "n", "v" }
    },
    {
        '<leader>ab',
        function()
            require("avante.api").build()
        end,
        desc = "Build dependencies",
        mode = { "n", "v" }
    },
    {
        '<leader>as',
        function()
            require("avante.api").stop()
        end,
        desc = "Stop agent from running",
        mode = { "n", "v" }
    },
    {
        '<leader>as',
        function()
            require("avante.api").get_suggestion()
        end,
        desc = "Get agent suggestion",
        mode = { "n", "v" }
    },
    {
        '<leader>ac',
        function()
            require("avante.api").clear()
        end,
        desc = "Clear chat history",
        mode = { "n", "v" }
    },
    {
        '<leader>am',
        function()
            require("avante.api").select_model()
        end,
        desc = "Display models",
        mode = { "n", "v" }
    },
    {
        '<leader>ae',
        function()
            require("avante.api").edit()
        end,
        desc = "Edit prompt",
        mode = { "n", "v" }
    },
    {
        '<leader>ar',
        function()
            require("avante.api").refresh()
        end,
        desc = "Refresh prompt",
        mode = { "n", "v" }
    }
}
