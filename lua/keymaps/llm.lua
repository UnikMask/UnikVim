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
            require("avante.api").refresh()
        end,
        desc = "Build dependencies",
        mode = { "n", "v" }
    },
    {
        '<leader>as',
        function()
            require("avante.api").stop()
        end,
        desc = "Build dependencies",
        mode = { "n", "v" }
    },
    {
        '<leader>ac',
        function()
            require("avante.api").stop()
        end,
        desc = "Clear chat history",
        mode = { "n", "v" }
    },
    {
        '<leader>ap',
        function()
            require("avante.api").stop()
        end,
        desc = "Show repo structure",
        mode = { "n", "v" }
    },
    {
        '<leader>am',
        function()
            require("avante.api").models()
        end,
        desc = "Show repo structure",
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
