local capabilities
local get_capabilities = function()
    if capabilities == nil then
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities.offsetEncoding = "utf-8"
        capabilities.textDocument.semanticHighlighting = true
    end
    return capabilities
end

local on_attach = function(client, bufnr)
    return require("lsp-format").on_attach(client, bufnr)
end

local templ_format = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local cmd = "templ fmt " .. vim.fn.shellescape(filename)

    vim.fn.jobstart(cmd, {
        on_exit = function()
            -- Reload the buffer only if it's still the current buffer
            if vim.api.nvim_get_current_buf() == bufnr then
                vim.cmd("e!")
            end
        end,
    })
end

local opts = {}
opts.lspconfig_disable = { ["rust_analyzer"] = false, ["jdtls"] = false }
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
            capabilities = get_capabilities(),
            on_attach = on_attach,
            filetypes = { "astro", "templ", "javascript", "typescript", "react" },
            init_options = { userLanguages = { templ = "html" }, documentFormatting = false },
        },
        ["htmx-lsp"] = {
            capabilities = get_capabilities(),
            on_attach = on_attach,
            filetypes = { "html", "templ" },
            init_options = { documentFormatting = false },
        },
        ["html-lsp"] = {
            capabilities = get_capabilities(),
            on_attach = on_attach,
            filetypes = { "html", "templ" },
            init_options = { documentFormatting = false },
        },
        ["templ"] = {
            capabilities = get_capabilities(),
            on_attach = function(client, bufnr)
                return require("lsp-format").on_attach(client, bufnr)
            end,
        },
    }
end

-- Rust Options
opts.rust = function()
    return {
        server = {
            capabilities = get_capabilities(),
            on_attach = on_attach,
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
