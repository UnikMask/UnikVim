local M = {}
M.projects = {
    {
        "<leader>fw",
        function()
            require("telescope").extensions["neovim-project"].history({})
        end,
        desc = "Recent Projects",
    },
    {
        "<leader>fd",
        function()
            require("telescope").extensions["neovim-project"].discover({})
        end,
        desc = "Discover Projects",
    },
}

return M
