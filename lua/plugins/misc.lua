return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "rcarriga/nvim-notify",
        dependencies = {
            "UnikMask/iroh-vim",
        },
        lazy = true,
        event = "VimEnter",
        module = true,
        opts = {
            timeout = 100,
            fps = 60,
            top_down = true,
        },
        config = function(_, opts)
            require("notify").setup(opts)
            vim.notify = require("notify")
        end,
    },
    {
        "folke/which-key.nvim",
        opts = {},
        lazy = false,
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = "BufRead",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        lazy = true,
        event = "InsertEnter",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        lazy = true,
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = true,
        opts = {},
    },
    {
        "Dhanus3133/Leetbuddy.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        lazy = true,
        opts = {
            domain = "com",
            language = "py",
        },
        init = function()
            require("keymaps.misc").leetbuddy()
        end,
    },
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        opts = {},
        init = function()
            require("keymaps.misc").nvimSpider()
        end,
    },
    {
        "preservim/tagbar",
        lazy = true,
        cmd = { "TagbarToggle" },
        init = function()
            require("keymaps.misc").tagbar()
        end,
    },
    {
        "rareitems/anki.nvim",
        lazy = false,
        -- lazy -- don't lazy it, it tries to be as lazy possible and it needs to add a filetype association
        opts = {
            {
                -- this function will add support for associating '.anki' extension with both 'anki' and 'tex' filetype.
                tex_support = false,
                models = {
                    -- Here you specify which notetype should be associated with which deck
                    NoteType = "PathToDeck",
                    ["Basic"] = "Deck",
                    ["Super Basic"] = "Deck::ChildDeck",
                },
            },
        },
    },
    {
        "rest-nvim/rest.nvim",
        tag = "v3.2.0",
        lazy = true,
        keys = { { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run request" } },
        ft = { "http" },
        cmd = { "Rest" },
        config = function()
            require("telescope").load_extension("rest")
        end,
    },
}
