local wk = require('which-key')
local maps = {}

maps.lsp = function()
    wk.register({
        c = {
            name = 'Language Server',
            d = {vim.lsp.buf.definition, "Go to Definition"},
            a = {vim.lsp.buf.code_action, "Execute Code Action"},
            t = {vim.lsp.buf.type_definition, "See Type Definition"},
            D = {vim.lsp.buf.declaration, "Go to Declaration"},
            h = {vim.lsp.buf.hover, "Hover Definition"},
        }
    }, {prefix = '<leader>'})
end

return maps
