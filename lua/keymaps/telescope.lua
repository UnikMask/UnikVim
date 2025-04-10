-- Telescope keymaps
-- Loaded during config upon loading telescope

local bt = function()
    return require("telescope.builtin")
end
local sfp_arg = function()
    return {
        cwd = vim.api.nvim_list_runtime_paths()[1],
        hidden = true,
    }
end

local man_pages_nums = { name = "Man pages" }

local maps = {
    -- Command related
    {
        "<leader>x",
        function()
            bt().commands()
        end,
        desc = "Show commands",
    },
    {
        "<leader>T",
        function()
            bt().builtin()
        end,
        desc = "Telescope Builtins",
    },
    -- Help related
    {
        "<leader>hh",
        function()
            bt().help_tags()
        end,
        desc = "Neovim Help Tags",
    },
    {
        "<leader>hM",
        function()
            bt().man_pages({ sections = { "ALL" } })
        end,
        desc = "All man Pages",
    },
    -- Find related
    {
        "<leader>ff",
        function()
            bt().find_files({ hidden = false })
        end,
        desc = "Files in Directory",
    },
    {
        "<leader>fF",
        function()
            bt().find_files({ hidden = true })
        end,
        desc = "File Picker",
    },
    {
        "<leader>f~",
        function()
            bt().find_files({ cwd = "~", hidden = true })
        end,
        desc = "Files in Home Directory",
    },
    {
        "<leader>fp",
        function()
            bt().find_files(sfp_arg())
        end,
        desc = "Files in config",
    },
    {
        "<leader>fg",
        function()
            bt().live_grep()
        end,
        desc = "String in document",
    },
    {
        "<leader>ft",
        function()
            bt().tags()
        end,
        desc = "Project tags",
    },
    {
        "<leader>fb",
        function()
            bt().buffers()
        end,
        desc = "Buffers",
    },
    {
        "<leader>fr",
        function()
            bt().oldfiles()
        end,
        desc = "Recent files",
    },
    {
        "<leader>fw",
        function()
            require("telescope").extensions.projects.projects({})
        end,
        desc = "Project",
    },
    {
        "<leader>fs",
        function()
            require("telescope")
            require("auto-session.session-lens").search_session()
        end,
        desc = "Sessions",
    },
    {
        "<leader>fR",
        function()
            bt().registers({})
        end,
        desc = "Registers",
    },
    {
        "<leader>fc",
        function()
            bt().colorscheme({})
        end,
        desc = "Select Colorscheme",
    },
}
for i = 1, 8 do
    table.insert(maps, {
        "<leader>hm" .. tostring(i),
        function()
            bt().man_pages({ sections = { tostring(i) } })
        end,
        desc = "Section " .. tostring(i),
    })
end

return maps
