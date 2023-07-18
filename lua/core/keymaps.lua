-- General keymaps file

-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fp', function() 
    builtin.find_files{
    cwd='~/.config/nvim'
    }
end, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>pp', 
    function() require('telescope').extensions.projects.projects({}) end, {})

-- Neovim Tree keymaps
local ok, tree_api = pcall(require, 'nvim-tree.api')
if ok then
    vim.keymap.set('n', '<leader>op', tree_api.tree.toggle, {})
end

-- Window splitting keymaps
vim.keymap.set('n', '<leader>wv', function()
    vim.cmd('vsplit')
end, {})
vim.keymap.set('n', '<leader>ws', function()
    vim.cmd('split')
end, {})

