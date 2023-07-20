-- General keymaps file


-- Window splitting keymaps
vim.keymap.set('n', '<leader>wv', function()
    vim.cmd('vsplit')
end, {})
vim.keymap.set('n', '<leader>ws', function()
    vim.cmd('split')
end, {})

