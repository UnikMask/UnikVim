local groups = {
    { "<leader>g",  group = "Git" },
    { "<leader>e",  group = "Open" },
    { "<leader>q",  group = "Sessions" },
    { "<leader>L",  group = "Lazy" },
    { "<leader>o",  group = "Orgmode" },
    { "<leader>n",  group = "Notifications" },
    { "<leader>t",  group = "Tasks" },
    { "<leader>l",  group = "Leetbuddy" },
    { "<leader>c",  group = "Coding/Language" },
    { "<leader>d",  group = "Debugger" },
    { "<leader>dd", group = "Run" },
    { "<leader>dw", group = "Widgets" },
    { "<leader>b",  group = "Buffers" },
    { "<leader>a",  group = "LLMs/AI tooling" },
    { "<leader>f",  group = "Find" },
    { "<leader>h",  group = "Help" },
    { "<leader>r",  group = "Terminal" },
}

for i = 1, 9 do
    table.insert(groups, { "<leader>r" .. tostring(i), group = "Terminal " .. tostring(i) })
end

return groups
