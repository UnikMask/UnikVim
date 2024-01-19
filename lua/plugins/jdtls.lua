-- Full configuration for JDTLS
-- As the JDTLS configuration is way longer than for any other LSP
-- (thanks Eclipse), it is in its separate file.
-- Many thanks to github.com/VonHeikemen/lsp-zero.nvim nvim-jdtls guide
-- For the JDTLS setup guide! Most of the configuration is based on this.

local cache_vars = {}

local opts = function()
    if cache_vars.opts then
        return cache_vars.opts
    end
    cache_vars.opts = require("opts.jdtls")
    return cache_vars.opts
end

-- Set up and return the JDTLS path on this computer using Mason.
local get_jdtls_paths = function()
    if cache_vars.paths then
        return cache_vars.paths
    end
    local path = {}
    path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"

    -- Get JDTLS path
    local jdtls_install = require("mason-registry").get_package("jdtls"):get_install_path()
    path.java_agent = jdtls_install .. "/lombok.jar"
    path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

    -- Get required config
    local osconfig = "/config_linux"
    if vim.fn.has("mac") == 1 then
        osconfig = "/config_mac"
    elseif vim.fn.has("win32") == 1 then
        osconfig = "/config_win"
    end
    path.platform_config = jdtls_install .. osconfig

    -- Include java-test
    path.bundles = {}
    local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()
    local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")
    if java_test_bundle[1] ~= "" then
        vim.list_extend(path.bundles, java_test_bundle)
    end

    -- Include java-dap
    local java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()
    local java_debug_bundle =
        vim.split(vim.fn.glob(java_debug_path .. "/extensions/server/com.microsft.java.debug.plugin-*.jar"), "\n")
    if java_debug_bundle[1] ~= "" then
        vim.list_extend(path.bundles, java_debug_bundle)
    end

    -- Set up available runtimes on my PC
    path.runtimes = {
        {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk",
        },
        {
            name = "JavaSE-1.8",
            path = "/usr/lib/jvm/java-8-openjdk",
        },
        -- Not supported yet
        -- {
        -- 	name = "JavaSE-21",
        -- 	path = "/usr/lib/jvm/java-21-openjdk",
        -- },
    }
    cache_vars.paths = path
    return path
end

-- Enable CodeLens on current buffer
local enable_codelens = function(bufnr)
    pcall(vim.lsp.codelens.refresh)
    vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = bufnr,
        group = opts().augroup,
        desc = "Refresh CodeLens",
        callback = function()
            pcall(vim.lsp.codelens.refresh)
        end,
    })
end

-- Enable Debugger on current buffer
local enable_debugger = function(_)
    -- TODO: Enable debugger using which-key
end

-- Add bindings and features when JDTLS client attaches to buffer
local jdtls_on_attach = function(_, bufnr)
    if opts().features.debugger then
        enable_debugger(bufnr)
    end
    if opts().features.codelens then
        enable_codelens(bufnr)
    end

    -- TODO: Add onAttach commands using which-key
end

-- Set up JDTLS with correct config and features.
local setup_jdtls = function()
    local jdtls = require("jdtls")
    local path = get_jdtls_paths()
    local data_dir = path.data_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

    -- Get client capabilities
    if cache_vars.capabilities == nil then
        jdtls.extendedClientCapabilities.resolveAdditionalTextEditSupport = true
        local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
        cache_vars.capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            ok_cmp and cmp_lsp.default_capabilities() or {}
        )
    end

    -- Command that starts language server
    local cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. path.java_agent,
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        path.launcher_jar,
        "-configuration",
        path.platform_config,
        "-data",
        data_dir,
    }

    local lsp_settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = path.runtimes,
            },
            maven = {
                downloadSources = true,
            },
            implementationCodeLens = {
                enabled = true,
            },
            format = {
                settings = {
                    url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                },
            },
        },
        signatureHelp = {
            enabled = true,
        },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
        },
        contentProvider = {
            preferred = "fernflower",
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                useBlocks = true,
            },
        },
    }

    -- Start JDTLS client
    jdtls.start_or_attach({
        cmd = cmd,
        settings = lsp_settings,
        on_attach = jdtls_on_attach,
        capabilities = cache_vars.capabilities,
        root_dir = jdtls.setup.find_root(opts().root_files),
        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            bundles = path.bundles,
        },
    })
end

-- Lazy.nvim --

return {
    {
        "mfussenegger/nvim-jdtls",
        lazy = true,
        ft = { "java", "kotlin", "scala" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
        },
        config = function()
            -- Set up autocommand for JDTLS
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = opts().augroup,
                pattern = { "java", "kotlin", "scala" },
                desc = "Setup JDTLS",
                callback = setup_jdtls,
            })
            setup_jdtls()
        end,
    },
}
