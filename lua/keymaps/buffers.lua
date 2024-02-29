local wk = require('which-key')

local vimFunc = function(cmd)
    return '<Cmd>' .. cmd .. '<CR>'
end

local t = {
    b = {
        name = 'Buffers',
        k = { vimFunc('bd'), 'Close Window' },
        c = { vimFunc('enew'), 'Close Buffer' },
        n = { vimFunc('bnext'), 'Next buffer' },
        p = { vimFunc('bprevious'), 'Previous buffer' }
    }
}
wk.register(t, { prefix = '<leader>' })
