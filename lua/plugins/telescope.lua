return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "rcarriga/nvim-notify",
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
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
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    }
                },
                pickers = {
                    find_files = {
                        theme = "ivy",
                    },
                },
            })

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
