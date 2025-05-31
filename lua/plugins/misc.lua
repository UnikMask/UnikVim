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
        keys = require("keymaps.misc").notify,
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
        event = "VeryLazy",
        opts = {
            modes = {
                buf_diagnostics = {
                    mode = "diagnostics",
                    filter = {
                        any = {
                            buf = 0,
                            {
                                severity = vim.diagnostic.severity.ERROR,
                                function(item)
                                    return item.filename:find((vim.oop or vim.uv).cwd(), 1, true)
                                end,
                            },
                        },
                    },
                },
                diagnostics_errors = {
                    mode = "diagnostics",
                    filter = {
                        severity = vim.diagnostic.severity.ERROR,
                    },
                },
                diagnostics_warnings = {
                    mode = "diagnostics",
                    filter = {
                        severity = vim.diagnostic.severity.WARN,
                    },
                },
                diagnostics_hints = {
                    mode = "diagnostics",
                    filter = {
                        severity = vim.diagnostic.severity.HINT,
                    },
                },
                diagnostics_ft_project = {
                    mode = "diagnostics",
                    filter = {
                        -- function(item)
                        --     return item.filetype == vim.bo.filetype
                        -- end,
                        function(item)
                            return item.filename:find((vim.oop or vim.uv).cwd(), 1, true)
                        end,
                    },
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.3,
                    },
                },
                preview_float = {
                    mode = "diagnostics",
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.3,
                    },
                },
            },
        },
        config = function(_, opts)
            require("trouble").setup(opts)
            vim.api.nvim_create_autocmd("QuickFixCmdPost", {
                callback = function()
                    vim.cmd([[Trouble qflist open]])
                end,
            })
        end,
    },
    {
        "Dhanus3133/Leetbuddy.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        lazy = true,
        opts = {
            domain = "com",
            language = "py",
        },
        keys = require("keymaps.misc").leetbuddy,
    },
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        opts = {},
        keys = require("keymaps.misc").nvimSpider,
    },
    {
        "preservim/tagbar",
        lazy = true,
        cmd = { "TagbarToggle" },
        keys = require("keymaps.misc").tagbar,
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
    {
        "3rd/image.nvim",
        lazy = true,
        event = "VeryLazy",
    },
}
