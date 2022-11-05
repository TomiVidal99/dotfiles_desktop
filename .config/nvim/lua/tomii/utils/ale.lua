-- Configuration for the linter engine ALE: https://github.com/dense-analysis/ale

-- TODO: check if the linter it's installed

vim.cmd [[
  let b:ale_linters = ['eslint']
  let g:ale_linters_explicit = 1
  let g:ale_sign_error = '✘'
  let g:ale_sign_warning = '⚠'
  let g:ale_fixers = {
    \  'javascript': ['eslint'],
  \}
  let g:ale_fix_on_save = 1
]]
