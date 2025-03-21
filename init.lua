-- Load SPC as leader

-- Load final keymaps
local setLeader = function(key)
    vim.g.mapleader = key
    vim.g.maplocalleader = key
    vim.keymap.set({ "n", "v" }, key, "<nop>", { silent = true })
end
setLeader(" ")

-- Load options
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.termguicolors = true
vim.o.number = true
vim.o.autoindent = true
vim.o.wrap = false
vim.o.clipboard = "unnamedplus"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.guifont = "FiraCode Nerd Font Mono 12"
vim.g.barbar_auto_setup = false

vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

-- Load Lazy
require("core.lazy")

-- Setup mason if on
local ok, mason = pcall(require, "mason")
if ok then
    mason.setup()
end

-- Custom filetype support
vim.filetype.add({ extension = { templ = "templ" } })

-- Load Independent Keymaps
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
    wk.add(require("keymaps.buffers"))
end

-- Load core LSP utils
require("core.lsp")

-- Load Colorscheme
for _, name in pairs({ "iroh" }) do
    local cs_ok, _ = pcall(vim.cmd.colorscheme, name)
    if cs_ok then
        return
    end
end
