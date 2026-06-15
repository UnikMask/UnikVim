-- Suite of plugins related to LLM completion
return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false,
        dependencies = {
            "romus204/tree-sitter-manager.nvim",
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
            -- nvim-cmp integration dependencies
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "ibhagwan/fzf-lua",
        },
        opts = {
            provider = "gemini",
            rag_service = {
                enabled = true,
                runner = "nix",
                host_mount = os.getenv("HOME"),
            },
            -- instruction_file = "avante.md",
            providers = {
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-sonnet-4-5",
                },
                groq = {
                    endpoint = "https://api.groq.com/openai/v1",
                    model = "llama-3.3-70b-versatile",
                },
                deepseek = {
                    endpoint = "https://api.deepseek.com/v1",
                    model = "deepseek-chat",
                },
                gemini = {
                    endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
                    model = "gemini-3-pro-preview",
                },
            },
            acp_providers = {
                ["claude-code"] = {
                    command = "npx",
                    args = { "@zed-industries/claude-caude-acp" },
                    env = {
                        NODE_NO_WARNINGS = 1,
                        ANTHROPIC_API_KEY = os.execute("secret-tool lookup name anthropic-unikvim-key"),
                    },
                },
            },
            behaviour = {
                -- auto_suggestions = true,
                timeout = 30000,
                max_completion_tokens = 8192,
            },
            file_selector = {
                provider = "fzf",
            },
            suggestion = {
                debounce = 600,
                throttle = 600,
            },
        },
        keys = require("keymaps.llm"),
        build = "make",
    },
}
