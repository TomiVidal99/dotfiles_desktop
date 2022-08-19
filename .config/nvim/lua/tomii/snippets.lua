-- Some custom snippets for LuaSnip
local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  print "ERROR: luasnipt not available. Called from snippets.lua"
  return
end

local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.snippets = {
  lua = {
    s("req", fmt("local {} = require('{}')", {i(1, "default"), rep(1)})),
  }
--  typescriptreact = {
--    ls.parser.parse_snippet = {
--
--    }
--  }
}
