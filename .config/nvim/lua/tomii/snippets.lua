-- Some custom snippets for LuaSnip
local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  print "ERROR: luasnipt not available. Called from snippets.lua"
  return
end

local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = extras.m
local l = extras.l
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

-- some basic settings
ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opt = nil,
})

local function get_filename()
  local file = vim.fn.expand("%")
  return string.gsub(file, ".vhd", "")
end

ls.add_snippets("vhdl", {
	s({
    trig="vhdl",
    name="VHDL template",
    dscr="VHDL basic template for starting to design a hardware",
  }, {
    t({"library IEEE;"}),
    t({"", "use IEEE.std_logic_1164.all;"}),
    t({"", ""}),
    t({"", "entity "}), f(get_filename, {}), t({" is"}),
    t({"", "\tPORT("}),
    t({"", "\t\ti_"}), i(1), t({"\t\t: IN  std_logic;"}),
    t({"", "\t\to_"}), i(2), t({"\t\t: OUT std_logic"}),
    t({"", "\t);"}),
    t({"", "end entity;"}),
    t({"", ""}),
    t({"", "architecture "}), t({"A1 of "}), f(get_filename, {}), t({" is"}),
    t({"", "begin"}),
    t({"", ""}),
    t({"", ""}), i(0),
    t({"", ""}),
    t({"", "end A1;"}),
  }),
})

ls.add_snippets("vhdl", {
	s({
    trig="process",
    name="VHDL process",
    dscr="VHDL process template for inside an architecture",
  }, {
    t({"", "-- "}), i(1), t({""}),
    t({"", ""}), i(2), t({":"}),
    t({"", "process("}), i(3), t({") is"}),
    t({"", "begin"}),
    t({"", ""}),
    t({"", ""}),
    i(0),
    t({"", ""}),
    t({"", "end process;"}),
  }),
})

ls.add_snippets("vhdl", {
	s({
    trig="if",
    name="If statement",
    dscr="If statement for VHDL",
  }, {
    t({"if ("}), i(1), t({") then"}),
    i(0),
    t({"", "end if;"}),
  }),
})

ls.add_snippets("vhdl", {
	s({
    trig="elsif",
    name="If statement (else if)",
    dscr="If statement (else if) for VHDL",
  }, {
    t({"elsif ("}), i(0), t({") then"}),
  }),
})

ls.add_snippets("cs", {
	s({
    trig="summ",
    name="Summary comment",
    dscr="Descriptive comment for the summary",
  }, {
    t({"/// <summary>", ""}),
    t({"/// "}), i(0), t({"", ""}),
    t({"/// </summary>"}),
  }),
})

