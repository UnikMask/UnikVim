local opts = {
	features = {
		codelens = true,
		debugger = false,
	},
	augroup = vim.api.nvim_create_augroup("NvimJDTLS", { clear = true }),
	root_files = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
}

return opts
