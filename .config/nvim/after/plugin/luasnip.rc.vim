lua << EOF
--require("luasnip.loaders.from_vscode").load({ paths = { "./snippets" } }) -- Load snippets from my-snippets folder

-- Define some snippets
--require("luasnip").snippets = {
  -- Snippets for all filetypes
  --all = { ... }
  -- Snippets for filetype=python
  --python = { ... }
--}

-- Load snippets from JSON files (VSCode syntax)
--require("luasnip/loaders/from_vscode").lazy_load({
--  paths = {
--    vim.fn.stdpath('config') .. '/snippets',
--  }
--})

EOF
