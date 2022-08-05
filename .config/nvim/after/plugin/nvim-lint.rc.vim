" Setup the linters

lua << EOF

require("lint").linters_by_ft = {
    python = {"pylint"},
    javascript = {"eslint"},
    typescript = {"eslint"},
    go = {"golangcilint"}
}

-- require("lint.linters.pylint").args = {
--     "-f",
--     "json",
--     "--rcfile=~/.config/nvim/lint/pylint.conf"
-- }


-- vim.cmd([[
-- au BufEnter * lua require('lint').try_lint()
-- au BufWritePost * lua require('lint').try_lint()
-- ]])

EOF
