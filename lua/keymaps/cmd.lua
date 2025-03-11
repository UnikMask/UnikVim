local get_term_keys = function(num)
    return {
        {
            "<leader>r" .. tostring(num) .. "h",
            function()
                require("toggleterm").toggle_command("direction=horizontal", num)
            end,
            desc = "Toggle Terminal (Horizontal)",
        },
        {
            "<leader>r" .. tostring(num) .. "f",
            function()
                require("toggleterm").toggle_command("direction=float", num)
            end,
            desc = "Toggle Terminal (Float)",
        },
        {
            "<leader>r" .. tostring(num) .. "v",
            function()
                require("toggleterm").toggle_command("direction=vertical size=60", num)
            end,
            desc = "Toggle Terminal (Vertical)",
        },
    }
end

local Terminal = function()
    return require("toggleterm.terminal").Terminal
end
local MusicPlayer = nil
local toggleMusicPlayer = function()
    if MusicPlayer == nil then
        MusicPlayer = Terminal():new({ cmd = "ncmpcpp", hidden = true, direction = "float" })
    end
    MusicPlayer:toggle()
end
local toggleMidnightCommander = function()
    Terminal():new({ cmd = "mc", hidden = true, direction = "float" }):toggle()
end

local toggleterm = {
    {
        "<leader>rh",
        function()
            require("toggleterm").toggle_command("direction=horizontal", nil)
        end,
        desc = "Toggle Terminal (Horizontal)",
    },
    {
        "<leader>rf",
        function()
            require("toggleterm").toggle_command("direction=float", nil)
        end,
        desc = "Toggle Terminal (Float)",
    },
    {
        "<leader>rv",
        function()
            require("toggleterm").toggle_command("direction=vertical size=60", nil)
        end,
        desc = "Toggle Terminal (Horizontal)",
    },
    {
        "<leader>fm",
        function()
            toggleMusicPlayer()
        end,
        desc = "Toggle music player",
    },
    {
        "<leader>mc",
        function()
            toggleMidnightCommander()
        end,
        desc = "Toggle External File Explorer",
    },
    { "<Escape>", "<C-\\><C-n>", "Escape terminal" },
}
for i = 1, 9 do
    for _, mapping in ipairs(get_term_keys(i)) do
        table.insert(toggleterm, mapping)
    end
end

return toggleterm
