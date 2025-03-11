local vimFunc = function(cmd)
    return '<Cmd>' .. cmd .. '<CR>'
end

return {
    { "<leader>bk", vimFunc('bd'),        desc = 'Close Window' },
    { "<leader>bc", vimFunc('enew'),      desc = 'Close Buffer' },
    { "<leader>bn", vimFunc('bnext'),     desc = 'Next Buffer' },
    { "<leader>bp", vimFunc('bprevious'), desc = 'Previous Buffer' }
}
