local ok, prettier = pcall(require, "prettier")
if not ok then
	print("ERROR: expected prettier to be available. Called from prettier.lua")
	return
end

prettier.setup({
	bin = "prettierd", -- or `'prettierd'` (v0.23.3+)
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
})
