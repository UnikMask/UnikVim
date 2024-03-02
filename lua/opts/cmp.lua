local opts = {}

local kind_icons = {
    Text = "󰉿",
    Method = "m",
    Function = "󰡱",
    Constructor = "",
    Field = "",
    Variable = "󰆧",
    Class = "󰌗",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰇽",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰊄",
}

opts["nvim-cmp"] = function()
    local luasnip = require("luasnip")
    local cmp = require("cmp")
    return {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            ["<C-i>"] = cmp.mapping(function(_)
                cmp.abort()
            end, { "i", "s" }),
            ["<C-j>"] = cmp.mapping(function(_)
                cmp.scroll_docs(4)
            end, { "i", "s" }),
            ["<C-k>"] = cmp.mapping(function(_)
                cmp.scroll_docs(-4)
            end, { "i", "s" }),
            ["<C-m>"] = cmp.mapping(function(_)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { "i", "s" }),
            ["<C-n>"] = cmp.mapping(function(_)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { "i", "s" }),
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
        },
    }
end

opts.buff_search = function()
    local cmp = require("cmp")
    return {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { {
            name = "buffer",
        } },
    }
end

opts.cmdline_search = function()
    local cmp = require("cmp")
    return {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "path" }, { name = "cmdline" } },
    }
end
return opts
