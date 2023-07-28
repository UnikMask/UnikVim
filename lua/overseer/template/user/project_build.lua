local get_os = function()
    return package.config:sub(1, 1) == "\\" and "bat" or "linux"
end

return {
    name = "Build Project",
    builder = function()
        local build_path = (vim.fs.find(string.format('build.%s', get_os()), {
            upward = true,
            stop = require('project_nvim.project').get_project_root(),
            path = require('project_nvim.project').get_project_root()
        }))[1]
        local project_name = vim.fs.basename(require("project_nvim.project").get_project_root())
        if build_path ~= nil then
            return {
                cmd = { build_path },
                args = {},
                name = "Build " .. project_name,
                components = {
                    "on_complete_notify", "default",
                },
            }
        else
            return {
                cmd = { "echo", "'No buildscript found!'" },
                name = string.format("Build %s - BUILDSCRIPT NOT FOUND", project_name),
                components = {
                    "on_complete_notify", { "on_output_parse", problem_matcher = "$tsc-watch" },
                    { "on_output_quickfix", set_diagnostics= true, open = true, open_on_exit = "failure" },
                    "default",

                },
            }
        end
    end,
    desc = "Build a project by calling its OS's build script.",
    -- tags = {require("overseer").TAG.BUILD},
    condition = {
        filetype = { "c", "cpp", "cmake" },
    }

}
