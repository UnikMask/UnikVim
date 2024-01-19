---@param opts overseer.SearchParams
---@return nil|string
local get_gradle_dir = function(opts)
    return vim.fs.find("gradle", { upward = true, type = "directory", path = opts.dir })[1]
end


return {
    name = "Build Gradle Project",
    builder = function(opts)
        local gradle_dir = assert(get_gradle_dir(opts))
        return {
            cmd = { "gradle", "build" },
            components = {
                "on_complete_notify",
                "on_complete_dispose",
                "default",
            },
            cwd = vim.fs.dirname(gradle_dir),
        }
    end,
    desc = "Build a Gradle Project",
    condition = {
        callback = function(opts)
            if not get_gradle_dir(opts) then
                return false, "Current project is not a Gradle project"
            end
            return true
        end,
    },
}
