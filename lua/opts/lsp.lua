local get_capabilities = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.offsetEncoding = "utf-8"
    capabilities.textDocument.semanticHighlighting = true
    return capabilities
end

local capabilities_no_utf8 = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- capabilities.textDocument.semanticHighlighting = true
    return capabilities
end

local get_capabilities_no_format = function()
    local capabilities_no_format = get_capabilities()
    capabilities_no_format.textDocument.formatting = false
    capabilities_no_format.documentFormattingProvider = false
    return capabilities_no_format
end

local on_attach = function(client, bufnr)
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    return require("lsp-format").on_attach(client, bufnr)
end

local opts = {}
opts.lspconfig_disable = { ["rust_analyzer"] = true, ["jdtls"] = false }
opts.lspconfig = function()
    return {
        ["lua_ls"] = {
            on_attach = on_attach,
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    -- workspace = {
                    -- 	library = {
                    -- 		[vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    -- 		[vim.fn.stdpath("config") .. "/lua"] = true,
                    -- 	},
                    -- },
                },
            },
            capabilities = get_capabilities(),
        },
        ["tailwindcss"] = {
            capabilities = get_capabilities_no_format(),
            filetypes = { "astro", "templ", "javascript", "typescript", "react" },
            init_options = { userLanguages = { templ = "html" }, documentFormatting = false },
        },
        ["tsserver"] = {
            capabilities = get_capabilities_no_format(),
        },
        ["htmx-lsp"] = {
            capabilities = get_capabilities_no_format(),
            filetypes = { "html", "templ" },
            init_options = { documentFormatting = false },
        },
        ["html-lsp"] = {
            capabilities = get_capabilities_no_format(),
            filetypes = { "html", "templ" },
            init_options = { provideFormatter = false },
        },
        ["sqls"] = {
            capabilities = get_capabilities_no_format(),
        },
        ["templ"] = {
            capabilities = get_capabilities(),
            on_attach = on_attach,
        },
    }
end

-- Rust Options
opts.rust = function()
    -- Set up autocommands for rust ctags
    local tags_group = vim.api.nvim_create_augroup("RustyTags", {})
    vim.api.nvim_create_autocmd({ "BufRead" }, {
        pattern = { "*.rs" },
        group = tags_group,
        callback = function()
            vim.bo.tags = "./rusty-tags.vi;/$RUST_SRT_PATH/rusty-tags.vi"
        end,
    })
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { "*.rs" },
        group = tags_group,
        callback = function()
            os.execute("rusty-tags vi --quiet --start-dir=" .. vim.fn.expand("%:p:h"))
            vim.api.nvim_exec2("redraw", {})
        end,
    })
    return {
        capabilities = capabilities_no_utf8(),
        on_attach = on_attach,
        default_settings = {
            ["rust-analyzer"] = {
                editor = {
                    formatOnSave = true,
                },
                check = {
                    command = "clippy"
                },
                cargo = {
                    features = { "all" },
                },
                procMacro = {
                    enable = true,
                },
                checkOnSave = true,
            },
        },
    }
end

opts.lsp_clangd = function()
    return {
        capabilities = get_capabilities(),
        on_attach = function(client, bufnr)
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
            on_attach(client, bufnr)
        end,
    }
end

opts.clangd = function()
    return {
        ast = {
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },
            highlights = {
                details = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    }
end

opts.mason = {}
opts.mason_lspconfig = {
    ensure_installed = {},
    automatic_installation = true,
}

return opts
