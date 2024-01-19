return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            signcolumn = true,
        },
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Git commit", "Git blame" },
        init = function()
            require("keymaps.misc").fugitive()
        end,
    },
}
