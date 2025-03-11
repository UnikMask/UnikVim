local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
    return
end
lazy.setup("plugins", {
    defaults = {
        lazy = true,
    },
    install = {
        missing = true,
        colorscheme = { "iroh", "doom-one", "habamax" },
    },
    dev = {
        path = "~/.config/nvim/local",
        fallback = true,
        patterns = { "UnikMask" },
    },
})
require("which-key").add(require("keymaps.misc").lazy)
require("which-key").add(require("keymaps.groups"))
