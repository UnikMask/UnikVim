local M = {}

M.roam = function()
    return {
        directory = '~/org/roam/',
    }
end

M.org = function()
    return {
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
        org_capture_templates = {
            s = {
                description = 'Standup Summary',
                template = '* %u Standup Summary\n\n',
                target = '~/org/standups/standup-%<%Y-%m-%d>.org'
            },
            T = {
                description = 'Todo',
                template = '* TODO %?\n %u',
                target = '~/org/todo.org'
            },
            j = {
                description = 'Journal',
                template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
                target = '~/org/journal.org'
            },
            J = {
                description = 'Journal',
                template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
                target = '~/sync/org/journal/%<%Y-%m>.org'
            },
            e = {
                description = 'Event',
                subtemplates = {
                    r = {
                        description = 'recurring',
                        template = '** %?\n %T',
                        target = '~/org/calendar.org',
                        headline = 'recurring'
                    },
                    o = {
                        description = 'one-time',
                        template = '** %?\n %T',
                        target = '~/org/calendar.org',
                        headline = 'one-time'
                    },
                },
            },
        }
    }
end

return M
