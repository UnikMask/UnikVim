local supported_langs = {
    'lua', 'c', 'java', 'python', 'vim', 'vimdoc',
    'rust', 'cpp', 'cmake'
}


return {
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'ahmedkhalf/project.nvim',
        },
        lazy = true,
        keys = {
            {'<leader>gg', function() require('neogit').open() end},
        },
        cmd = { 'Neogit' },
        opts = {
            kind = 'split_above',
            popup = {
                kind = 'split_above',
            },
            disable_builtin_notifications = true,
            integrations = {
                telescope = true,
            }
        },
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = { 'Lazygit' },
        dependencies = {
            "nvim-lua/plenary.nvim",
            'ahmedkhalf/project.nvim'
        },
    },
    {
        'romgrk/barbar.nvim',
        lazy = false,
        dependencies = {
          'lewis6991/gitsigns.nvim',
          'nvim-tree/nvim-web-devicons',
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        config = function()
            require('barbar').setup({
            animation = true,
            auto_hide = true,
            separator = {left = '▎', right = ''},
            icons = {
                button = '',
            },
            })
        end,
        opts = {},
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'RRethy/vim-illuminate',
        },
        lazy = true,
        ft = supported_langs,
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = supported_langs,
                auto_install = true,
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            }
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
          "nvim-tree/nvim-web-devicons",
          "ahmedkhalf/project.nvim"
        },
        lazy = true,
        keys = {
            {'<leader>op'},
        },
        cmd = {
            'NvimTreeToggle', 'NvimTreeOpen',
        },
        config = function()
            require("nvim-tree").setup {
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true
                },
                vim.keymap.set('n', '<leader>op',
                    require('nvim-tree.api').tree.toggle,
                    {desc = 'Neovim-tree'})
            }
        end,
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        dependencies = {
            'rcarriga/nvim-notify',
        },
        keys = {
            {'<leader>ql', function()
                require('auto-session').RestoreSession()
            end},
        },
        opts = {
            log_level = vim.log.levels.INFO,
            auto_session_enabled = false,
            auto_save_enabled = true,
            auto_restore_enabled = false,
            auto_session_create_enabled = true,
            auto_session_enable_last_session =
                vim.loop.cwd() == vim.loop.os_homedir(),
            session_lens = {
                load_on_setup = false,
                theme_conf = { border = true },
                previewer = false,
            },
        },
        config = function (_, opts)
            require('auto-session').setup(opts)

            vim.api.nvim_create_autocmd({ "VimLeave" }, {
                group = vim.api.nvim_create_augroup('UserAutoSession', {}),
                callback = function()
                    require('auto-session').SaveSession()
                end,
            })
        end
    }
}
