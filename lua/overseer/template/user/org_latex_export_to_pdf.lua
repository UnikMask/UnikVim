return {
    name = "Export to PDF",
    builder = function()
        local file = vim.api.nvim_buf_get_name(0)
        return {
            cmd = { 'PATH=$PATH:$HOME/.emacs.d/bin:$HOME/.doom.d/bin', 'export-notes' },
            args = { file },
            name = vim.fn.fnamemodify(file, ":p:r") .. ".pdf",
            components = {
                "on_complete_notify",
                "default",
                "on_complete_dispose",
            }
        }
    end,
    desc = "Convert an org file to PDF",
    condition = { filetype = { "org" } },
}
