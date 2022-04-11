if !exists('g:loaded_cmp') | finish | endif

set completeopt=menuone,noinsert,noselect

lua << EOF
  local cmp = require'cmp'
  local lspkind = require'lspkind'

  cmp.setup({

    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

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

    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
      { name = 'buffer', keyword_length = 3 },
      --{ name = 'cmp_matlab' },
      --{ name = 'cmp_octave' },
    }),

    formatting = {
      format = lspkind.cmp_format({
        with_text = false,
        maxwidth = 50,
        menu = {
          buffer = "[text]",
          nvim_lua = "[api]",
          nvim_lsp = "[LSP]",
          luasnip = "[snip]",
          path = "[path]",
          cmp_matlab = "[matlab]",
          cmp_octave = "[octave]",
        },
      })
    },

    experimental = {
      native = true,
      ghost_text = true,
    }

  })

  vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]
EOF

