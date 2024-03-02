return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
            {
                'L3MON4D3/LuaSnip',
                build = 'make install_jsregexp',
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lua',
            "rafamadriz/friendly-snippets",
        },
        lazy = true,
        event = 'InsertEnter',
        config = function()
            require("luasnip/loaders/from_vscode").lazy_load()
            require("cmp").setup(require("opts.cmp")["nvim-cmp"]())
            require("cmp").setup.cmdline({ '/', '?' }, require("opts.cmp").buff_search())
            require("cmp").setup.cmdline(':', require("opts.cmp").cmdline_search())
        end
    }
}
