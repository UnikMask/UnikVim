-- Suite of plugins related to LLM completion
return {
    {
        "yetone/avante.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            {
                -- Make sure to set this up properly if you have lazy=true
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
            "MunifTanjim/nui.nvim",
        },
        event = "BufRead",
        opts = {
            provider = "claude",
            cursor_applying_provider = "groq",
            claude = {
                api_key_name = "cmd:rbw get anthropic-unikvim-key",
                model = "claude-3-7-sonnet-latest",
            },
            vendors = {
                mistral = {
                    __inherited_from = "openai",
                    api_key_name = "cmd:rbw get mistral-unikvim-key",
                    endpoint = "https://api.mistral.ai/v1",
                    model = "mistral-large-latest",
                    temperature = 0.7,
                    max_tokens = 16384,
                },
                codestral = {
                    __inherited_from = "openai",
                    api_key_name = "cmd:rbw get codestral-unikvim-key",
                    endpoint = "https://codestral.mistral.ai/v1",
                    -- model = "codestral",
                    temperature = 0.7,
                    max_tokens = 8192,
                },
                groq = {
                    __inherited_from = "openai",
                    api_key_name = "cmd:rbw get groq-unikvim-key",
                    endpoint = "https://api.groq.com/openai/v1",
                    model = "llama-3.3-70b-versatile",
                    max_tokens = 32768,
                }
            },
            behaviour = {
                enable_cursor_planning_mode = true,
                timeout = 30000,
                temperature = 0,
                max_completion_tokens = 8192,
            },
        },
        keys = require("keymaps.llm"),
        build = "make",
    },
}
