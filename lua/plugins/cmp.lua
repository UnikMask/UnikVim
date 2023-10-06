return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
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
        end
    }
}
