-- Configuration to use when running LSPs
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        require("which-key").add(require("keymaps.lsp"))
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        require("lsp-format").on_attach(client, args.buf)
    end,
})

-- Set LSP signs
local signs = { Error = "󰅚 ", Warn = " ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                globals = { "vim", "require" },
            },
            -- workspace = {
            -- 	library = {
            -- 		[vim.fn.expand("$VIMRUNTIME/lua")] = true,
            -- 		[vim.fn.stdpath("config") .. "/lua"] = true,
            -- 	},
            -- },
        },
    },
})
vim.lsp.config("tailwindcss", {
    filetypes = { "astro", "templ", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" }, documentFormatting = false },
})

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

vim.lsp.config("rust-analyzer", require("opts.lsp")["rust"])
vim.g.rustaceanvim = {
    tools = {},
    dap = require("opts.dap")["rustaceanvim"](),
}
