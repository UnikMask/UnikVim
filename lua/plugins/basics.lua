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
        cmd = { 'Neogit' },
        init = function()
            require('keymaps.misc').neogit()
        end,
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
        lazy = true,
        event = 'VeryLazy',
        dependencies = {
          'lewis6991/gitsigns.nvim',
          'nvim-tree/nvim-web-devicons',
        },
        opts = {
            animation = true,
            auto_hide = true,
            separator = {left = '▎', right = ''},
            icons = {
                button = '',
            },
        },
        init = function() vim.g.barbar_auto_setup = false end,
        config = function(_, opts)
            require('barbar').setup(opts)
            require('keymaps.barbar')
        end,
    },
    {
        'folke/which-key.nvim',
        opts = {},
        lazy = true,
        event = 'VeryLazy',
        init = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
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
        cmd = {
            'NvimTreeToggle', 'NvimTreeOpen',
        },
        init = function ()
            require('keymaps.misc').nvimtree()
        end,
        opts =  {
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true
            },
        },
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        opts = {
            log_level = vim.log.levels.WARN,
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
        init = function ()
            require('keymaps.misc').auto_session()
        end,
        config = function (_, opts)
            require('auto-session').setup(opts)

            vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
                group = vim.api.nvim_create_augroup('UserAutoSession', {}),
                callback = function()
                    require('auto-session').SaveSession()
                end,
            })
        end
    }
}
