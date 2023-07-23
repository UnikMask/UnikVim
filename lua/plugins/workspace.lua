return {
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
        init = function()
            require('keymaps.misc').nvimtree()
        end,
        opts = {
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            detection_methods = {
                "lsp", "pattern",
            },
            update_focused_file = {
                enable = true,
                update_root = true
            },
        },
    },
    {
        'ahmedkhalf/project.nvim',
        lazy = true,
        config = function()
            require('project_nvim').setup({})
        end
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        opts = {
            log_level = vim.log.levels.INFO,
            auto_session_enabled = false,
            auto_save_enabled = true,
            auto_restore_enabled = false,
            auto_session_create_enabled = true,
            auto_session_enable_last_session =
                vim.loop.cwd() == vim.loop.os_homedir(),
            pre_save_cmds = {
                function()
                    local ok =
                        require('lazy.core.config')
                        .plugins['nvim-tree.lua']._.loaded ~= nil
                    if ok then
                        require('nvim-tree.api').tree.close()
                    end
                end },
            session_lens = {
                load_on_setup = false,
                theme_conf = { border = true },
                previewer = false,
            },
        },
        init = function() require('keymaps.misc').auto_session() end,
        config = function(_, opts)
            require('auto-session').setup(opts)

            vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
                group = vim.api.nvim_create_augroup('UserAutoSession', {}),
                callback = function()
                    if vim.loop.cwd() ~= vim.loop.os_homedir() then
                        require('auto-session').SaveSession()
                    end
                end,
            })
        end
    }
}
