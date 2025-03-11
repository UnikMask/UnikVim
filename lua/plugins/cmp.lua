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
            local cmp = require("cmp")
            local opts_cmp = require("opts.cmp")
            require("luasnip/loaders/from_vscode").lazy_load()
            cmp.setup(opts_cmp["nvim-cmp"]())
            cmp.setup.cmdline({ '/', '?' }, opts_cmp.buff_search())
            cmp.setup.cmdline(':', opts_cmp.cmdline_search())
        end
    }
}
