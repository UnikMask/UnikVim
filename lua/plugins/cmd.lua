return {
    {
        "stevearc/overseer.nvim",
        lazy = true,
        cmd = { "OverseerRun", "OverseerToggle", "OverseerInfo" },
        init = function()
            require('keymaps.misc').overseer_init()
        end,
        opts = {
            strategy = {
                "toggleterm",
                shell = true,
                auto_scroll = true,
                open_on_start = false,
            },
            templates = {
                "builtin",
                "user.gradle_build",
                "user.org_latex_export_to_pdf",
                "user.project_build",
                "user.project_config",
            },
        },
        config = function(_, opts)
            require("overseer").setup(opts)
            require("keymaps.misc").overseer_config()
        end
    },
    {
        'akinsho/toggleterm.nvim',
        lazy = true,
        cmd = { "ToggleTerm", "TermExec" },
        version = "*",
        opts = {},
        init = function()
            require("keymaps.cmd")()
        end
    }
}
