local get_os = function()
    return package.config:sub(1, 1) == "\\" and "windows" or "linux"
end


return {
    name = "Configure project",
    builder = function()
        local dir = require("project_nvim.project").get_project_root()
        local files = get_os() == "windows"
            and { "configure.windows", "configure.bat" }
            or { "configure.linux", "configure.sh" }
        local proj_name = vim.fs.basename(dir)
        local config = (vim.fs.find(files, {
            upward = true,
            stop = dir,
            path = dir,
        }))[1]
        return {
            cmd = {config},
            args = {},
            name = "Configure " .. proj_name,
            components = {
                 "on_complete_notify", "default"
            },
            run_after = {
                "user.project_build"
            },
        }

    end,
    condition = { filetype = { "c", "cpp", "cmake" } }
}
