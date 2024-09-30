return {
    {
        "nvim-orgmode/orgmode",
        lazy = true,
        dependencies = {
            "hrsh7th/nvim-cmp",
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
        },
        ft = { "org" },
        opts = {
            org_agenda_files = { "~/org/**/*.org" },
            org_default_notes_file = "~/org/notes.org",
            emacs_config = { executable_path = "/usr/bin/emacs", config_path = "~/.config/emacs/early-init.el" },
            org_custom_exports = {
                d = {
                    label = "Doom Export to PDF",
                    action = function(exporter)
                        local current_file = vim.api.nvim_buf_get_name(0)
                        local target = vim.fn.fnamemodify(current_file, ":p:r") .. ".pdf"
                        local cmd = string.format("export-notes", current_file)
                        local on_error = function(err)
                            vim.api.nvim_echo(err, true, {})
                        end
                        return exporter({ cmd }, target, nil, on_error)
                    end,
                },
            },
            -- org_capture_templates = {
            --     j = {
            --         description = 'Journal',
            --         template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            --         target = '~/org/agenda/journal.org'
            --     },
            --     T = {
            --         description = 'Todo',
            --         template = '* TODO %?\n %u',
            --         target = '~/org/agenda/todo.org'
            --     },
            -- },
            notifications = {
                reminder_time = { 0, 5, 10 },
            },
        },
        init = function()
            require("keymaps.misc").orgmode()
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "org" },
                },
                ensure_installed = { "org" },
            })
            require("orgmode").setup(opts)
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
