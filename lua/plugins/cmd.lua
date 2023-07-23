return {
    {
        "stevearc/overseer.nvim",
        lazy = true,
        init = function()
            require('keymaps.misc').overseer_init()
        end,
        opts = {
            templates = { "builtin", "user.project_build" },
        },
        config = function(_, opts)
            require("overseer").setup(opts)
            require("keymaps.misc").overseer_config()
        end
    }
}
