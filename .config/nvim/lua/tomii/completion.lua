-- All completion plugin's configurations

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  print("ERROR: require cmp failed. from: completion.lua")
  return
end

local lua_snip_ok, lua_snip = pcall(require, "luasnip")
if not lua_snip_ok then
  print("ERROR: require luasnipt engine failed. from: completion.lua")
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

vim.opt.completeopt = { "menu", "menuone", "noselect" }
if cmp == nil then return end
cmp.setup({
  snippet = {
    expand = function(args)
      lua_snip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-k>"] = cmp.mapping(function(fallback) -- goto to next position in snip
      if lua_snip.expandable() then
        lua_snip.expand()
      elseif lua_snip.expand_or_jumpable() then
        lua_snip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-j>"] = cmp.mapping(function(fallback) -- goto to previous position in snip
      if lua_snip.jumpable(-1) then
        lua_snip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex Symbol]",
        luasnip = "[Snippet]",
        path = "[Path]",
        buffer = "[Buffer]",
        spell = "[Grammar]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = "latex_symbols" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = 'spell' },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})
