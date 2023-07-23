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

-- Lazy.nvim setup
misc.lazy = function()
    wk.register({
        L = {
            name = 'Lazy',
            l = { require('lazy').home, 'Lazy Home'},
            p = { require('lazy').profile, 'Profile'},
            h = { require('lazy').health, 'Healthcheck'},
            H = { require('lazy').help, 'Help Page'},
            d = { require('lazy').debug, 'Debug Info'},

        }
    }, prefix)
end

-- Orgmode setup
misc.orgmode = function()
    wk.register({
        a = { function() require('orgmode').action('agenda.prompt', {opts = {buffer = false}}) end, 'org agenda'},
        c = { function() require('orgmode').action('capture.prompt', {opts = {buffer = false}}) end, 'org capture'},
    }, {prefix = '<leader>o'})
end

misc.notify = function()
    wk.register({
        n = {
            name = 'Notifications',
            h = { function() vim.cmd("Notifications") end, "History"},
        }
    }, prefix)
end

return misc
