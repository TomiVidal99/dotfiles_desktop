if !exists('g:loaded_cmp') | finish | endif

set completeopt=menuone,noinsert,noselect

lua <<EOF
  local cmp = require'cmp'
  local lspkind = require'lspkind'

  cmp.setup({

    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },

    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-x>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
      }),
    },

    sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
      { name = 'buffer', keyword_length = 3 },
    }),

    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        maxwidth = 50,
      })
    },

    experimental = {
      native_menu = false,
      ghost_text = true,
    }

  })

  vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]
EOF

