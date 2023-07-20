return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'ahmedkhalf/project.nvim',
            'rmagatti/auto-session',
            'tsakirist/telescope-lazy.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            "nvim-telescope/telescope-file-browser.nvim",
        },
        lazy = true,
        cmd = { 'Telescope' },
        keys = {
            {'<leader>ff', function()
                require('telescope.builtin').find_files()
            end},
            {'<leader>fp', function()
                require('telescope.builtin').find_files {
                    cwd=vim.api.nvim_list_runtime_paths()[1],
                }
            end},
            {'<leader>fg', function()
                require('telescope.builtin').live_grep()
            end},
            {'<leader>fb', function()
                require('telescope.builtin').buffers()
            end},
            {'<leader>fh', function()
                require('telescope.builtin').help_tags()
            end},
            {'<leader>fr', function()
                require('telescope.builtin').oldfiles()
            end},
            {'<leader>pp', function()
                require('telescope').extensions.projects.projects({})
            end}
        },
        config = function()
            -- Load Telescope
            local telescope = require('telescope')
            telescope.setup({
                pickers = {
                    find_files = {
                    theme = "ivy"
                    }
                }
            })

            -- Setup extensions 
            require('auto-session').setup_session_lens()

            -- Load Telescope extensions
            local load_extensions = function(extensions)
                for _, ext in pairs(extensions) do
                    telescope.load_extension(ext)
                end
            end
            load_extensions{
                'lazy', 'fzf', 'file_browser', 'projects'
            }
        end
    },
    {
        'ahmedkhalf/project.nvim',
        lazy = true,
        config = function()
            require("project_nvim").setup {}
        end
    }
}
