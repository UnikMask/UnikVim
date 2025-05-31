return {
    {
        "nvim-orgmode/orgmode",
        -- version = "*",
        lazy = true,
        dependencies = {
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-orgmode/telescope-orgmode.nvim",
            {
                "akinsho/org-bullets.nvim",
                opts = {
                    list = "•",
                    headlines = { "◉", "○", "✸", "✿" },
                    checkboxes = {
                        half = { "", "OrgTSCheckboxHalfChecked" },
                        done = { "✓", "OrgDone" },
                        todo = { "˟", "OrgTODO" },
                    },
                },
            },
            {
                "https://github.com/lukas-reineke/headlines.nvim",
            },
        },
        ft = { "org" },
        keys = require("keymaps.misc").orgmode,
        config = function(_, _)
            require("telescope").load_extension("orgmode")
            require("orgmode").setup(require("opts.org").org())
            require("cmp").setup.filetype("org", {
                sources = require("cmp").config.sources({
                    { name = "orgmode" },
                }, { name = "buffer" }),
            })
        end,
    },
    {
        "chipsenkbeil/org-roam.nvim",
        lazy = true,
        version = "*",
        enabled = false,
        event = "VeryLazy",
        ft = { "org" },
        dependencies = {
            "nvim-orgmode/orgmode",
        },
        config = function()
            require("org-roam").setup(require("opts.org").roam())
        end,
    },
}
