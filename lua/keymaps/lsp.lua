local maps = {
    { "<leader>cd", vim.lsp.buf.definition,      desc = "Go to Definition" },
    { "<leader>ca", vim.lsp.buf.code_action,     desc = "Execute Code Action" },
    { "<leader>ct", vim.lsp.buf.type_definition, desc = "See Type Definition" },
    { "<leader>cD", vim.lsp.buf.declaration,     desc = "Go to Declaration" },
    { "<leader>ch", vim.lsp.buf.hover,           desc = "Hover Definition" },
    { "<leader>cf", vim.lsp.buf.format,          desc = "Format Document" },
    { "<leader>cr", vim.lsp.buf.rename,          desc = "Rename Action" },
    {
        "<leader>cm",
        function()
            vim.cmd("Man")
        end,
        desc = "Man Pages"
    },
    {
        "<leader>cc",
        function()
            require("trouble").toggle("diagnostics")
        end,
        desc = "Toggle Diagnostics"
    }
}

return maps
