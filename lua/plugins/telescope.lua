return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = {
            "rcarriga/nvim-notify",
            "nvim-lua/plenary.nvim",
            "rmagatti/auto-session",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        lazy = true,
        cmd = { "Telescope" },
        init = function()
            require("keymaps.telescope")
        end,
        config = function()
            -- Load Telescope
            local telescope = require("telescope")
            telescope.setup({
                extensions = {},
                pickers = {
                    find_files = {
                        theme = "ivy",
                    },
                },
            })

            -- Setup extensions
            require("auto-session").setup_session_lens()

            -- Load Telescope extensions
            local load_extensions = function(extensions)
                for _, ext in pairs(extensions) do
                    telescope.load_extension(ext)
                end
            end
            load_extensions({
                "fzf",
                "projects",
                "notify",
                "session-lens",
            })
        end,
    },
}
