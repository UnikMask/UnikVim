-- Configuration to use when running LSPs
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
	vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
	local lsp_map = function(lhs, rhs, desc)
	    vim.keymap.set("n", lhs, rhs, {
		silent = true,
		buffer = ev.buf,
		desc = desc
	    })
	end

    -- Keymapping when LSPs are active
	lsp_map('<leader>cd', vim.lsp.buf.definition, "Go to Definition")
	lsp_map('<leader>ca', vim.lsp.buf.code_action, "Execute Code Action")
	lsp_map('<leader>ct', vim.lsp.buf.type_definition, "See Type Definition")
	lsp_map('<leader>cgd', vim.lsp.buf.declaration, "Go to Declarations")
	lsp_map('<leader>h', vim.lsp.buf.hover, "Hover Definition")
    end
})

-- Set LSP signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
