return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        lazy = true,
        cmd = {
            "NvimTreeToggle",
            "NvimTreeOpen",
        },
        keys = require("keymaps.misc").nvimtree,
        opts = {
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true,
            },
        },
    },
    {
        "ahmedkhalf/project.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            patterns = { ".git", "Makefile", "*.sln", "" },
            detection_methods = {
                "lsp",
                "pattern",
            },
        },
        config = function(_, opts)
            require("project_nvim").setup(opts)
        end,
    },
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = {
            log_level = vim.log.levels.WARN,
            auto_save = true,
            auto_restore = false,
            use_git_branch = true,
            auto_create = true,
            suppressed_dirs = { "~", "~/gitrepos", "~/Downloads", "~/Documents" },
            lazy_support = true,
            auto_restore_last_session = false,
            close_unsupported_windows = true,
            pre_save_cmds = {
                function()
                    -- Close Nvim-Tree
                    local ok = require("lazy.core.config").plugins["nvim-tree.lua"]._.loaded ~= nil
                    if ok then
                        require("nvim-tree.api").tree.close()
                    end

                    -- Close Overseer page
                    ok = require("lazy.core.config").plugins["overseer"]._.loaded ~= nil
                    if ok then
                        require("overseer").close()
                    end
                end,
            },
            session_lens = {
                load_on_setup = false,
                theme_conf = { border = true },
                previewer = true,
            },
        },
        keys = require("keymaps.misc").auto_session,
        config = function(_, opts)
            require("auto-session").setup(opts)

            vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
                group = vim.api.nvim_create_augroup("UserAutoSession", {}),
                callback = function()
                    if vim.loop.cwd() ~= vim.loop.os_homedir() then
                        require("auto-session").SaveSession()
                    end
                end,
            })
        end,
    },
}
