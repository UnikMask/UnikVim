-- Load SPC as leader

-- Load final keymaps
local setLeader = function(key)
    vim.g.mapleader = key
    vim.g.maplocalleader = key
    vim.keymap.set({'n', 'v'}, key, '<nop>', {silent = true})
end
setLeader(' ')

-- Load options
vim.o.shiftwidth = 4
vim.o.tabstop= 4
vim.o.expandtab = true
vim.o.termguicolors = true
vim.o.number = true
vim.o.autoindent = true
vim.o.wrap = false
vim.o.clipboard = "unnamedplus"
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Load Lazy
require("core.lazy")

-- Setup mason if on
local ok, mason = pcall(require, "mason")
if ok then
    mason.setup()
end


-- Load core LSP utils
require('core.lsp')

-- Load Colorscheme
for _, name in pairs({"iroh"}) do
    local cs_ok, _ = pcall(vim.cmd.colorscheme, name)
    if cs_ok then
	return
    end
end
