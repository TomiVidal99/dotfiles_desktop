-- More LSP stuff: formatting, completion, diagnostics, etc.
local null_ok, null = pcall(require, "null-ls")
if not null_ok then
	print("ERROR: null-js not available. Called from null-js.lua")
	return
end

-- Settings
local formatting = null.builtins.formatting
local diagnostics = null.builtins.diagnostics
--local completion = null.builtins.completion

null.setup({
  on_init = function (new_client, _)
    new_client.offset_encoding = 'utf-32'
  end,
	sources = {
		-- LUA
		formatting.stylua,

		-- JS, TS, JSX, TSX
		formatting.prettier,
		diagnostics.eslint,

		-- Python
		diagnostics.pylint,
		formatting.black,
	},
})
