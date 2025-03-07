local wk = require("which-key")
local maps = {}

maps.lsp = function()
    wk.register({
        c = {
            name = "Language Server",
            d = { vim.lsp.buf.definition, "Go to Definition" },
            a = { vim.lsp.buf.code_action, "Execute Code Action" },
            t = { vim.lsp.buf.type_definition, "See Type Definition" },
            D = { vim.lsp.buf.declaration, "Go to Declaration" },
            h = { vim.lsp.buf.hover, "Hover Definition" },
            f = { vim.lsp.buf.format, "Format Document" },
            r = { vim.lsp.buf.rename, "Rename Action" },
            m = {
                function()
                    vim.cmd("Man")
                end,
                "Man Pages",
            },
            c = {
                function()
                    require("trouble").toggle("diagnostics")
                end,
                "Toggle Diagnostics",
            },
        },
    }, { prefix = "<leader>" })
end

maps.rust = function()
    wk.add({ {
        "<leader>cT",
        function()
            vim.cmd.RustLsp("testables")
        end,
    } })
end

return maps
