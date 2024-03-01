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
        init = function()
            require("keymaps.misc").nvimtree()
        end,
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
            detection_methods = {
                "lsp",
                "pattern",
            },
        },
        config = function(_, opts)
            require("project_nvim").setup(opts)
        end
    },
    {
        "rmagatti/auto-session",
        lazy = true,
        event = "BufRead",
        opts = {
            log_level = vim.log.levels.WARN,
            auto_session_enabled = false,
            auto_save_enabled = true,
            auto_restore_enabled = false,
            auto_session_create_enabled = true,
            auto_session_enable_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
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
                previewer = false,
            },
        },
        init = function()
            require("keymaps.misc").auto_session()
        end,
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
