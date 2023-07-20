local wk = require('which-key')

local vimFunc = function(cmd)
    return '<Cmd>' .. cmd .. '<CR>'
end

local t = {
    b = {
        name = 'Barbar',
        n = { vimFunc('BufferNext'), 'Next buffer'},
        p = { vimFunc('BufferPrevious'), 'Previous buffer'},
        m = {
            name = 'Move buffer',
            n = { vimFunc('BufferMoveNext'), 'Move next buffer'},
            p = { vimFunc('BufferMovePrevious'), 'Move previous buffer'},
        },
        b = {
            name = 'Buffer Actions',
            p = { vimFunc('BufferPin'), 'Pin Buffer'},
            c = { vimFunc('BufferClose'), 'Close Buffer'},
            r = { vimFunc('BufferRestore'), 'Restore Buffer'},
        },
        s = {
            name = 'Sort',
            n = { vimFunc('BufferOrderByBufferNumber'), 'Sort by Number'},
            d = { vimFunc('BufferOrderByDirectory'), 'Sort by directory'},
            l = { vimFunc('BufferOrderByLanguage'), 'Sort by language'},
            w = { vimFunc('BufferOrderByWindowNumber'), 'Sort by window number'},
        }
    }
}
for i = 1,9 do
    t.b[tostring(i)] = { vimFunc('BufferGoto ' .. tostring(i)), 'Move to buffer ' .. tostring(i)}
end
wk.register(t, { prefix = '<leader>'})
