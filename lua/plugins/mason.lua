return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        build = ":MasonUpdate",
        opts = require("opts.lsp")["mason"],
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        opts = require("opts.lsp")["mason_lspconfig"],
    }
}
