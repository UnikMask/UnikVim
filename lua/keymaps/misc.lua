local wk = require('which-key')
local misc = {}
local prefix = { prefix = '<leader>'}


-- Neogit setup
misc.neogit = function ()
    local neogit = function() return require('neogit') end
    wk.register({
        g = {
            name = 'Git',
            g = { function() neogit().open() end, 'Git status'},
        },
    }, prefix)
end

-- Nvim-tree setup
misc.nvimtree = function()
    local api = function() return require('nvim-tree.api') end
    wk.register({
        o = {
            name = 'Open',
            t = {function() api().tree.toggle() end, 'File Explorer tree'},
        }
    }, prefix)
end

-- Auto-session setup
misc.auto_session = function ()
    local auto_session = function() return require('auto-session') end
    wk.register({
        q = {
            name = 'Sessions',
            l = {function() auto_session().RestoreSession() end, 'Restore last session'},
        }
    }, prefix)
end

return misc
