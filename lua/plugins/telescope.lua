return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'tsakirist/telescope-lazy.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup({
            pickers = {
                find_files = {
                theme = "ivy"
                }
            }
            })
            local load_extensions = function(extensions)
            for _, ext in pairs(extensions) do
                telescope.load_extension(ext)
            end
            end
            load_extensions{
                'lazy', 'fzf', 'file_browser',
            }
            telescope.extensions = {
            rooter = {
                enable = true,
                patterns = {'.git'},
            }
            }
        end
    },
}
