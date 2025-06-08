return {
  {
    'xzbdmw/colorful-menu.nvim',
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'onsails/lspkind.nvim',
      'Saghen/blink.compat',
      'rcarriga/cmp-dap',
    },
    version = '1.*',
    build = 'cargo build --release',
    opts = {
      completion = {
        accept = { auto_brackets = { enabled = false } },
        menu = {
          draw = {
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              kind_icon = {
                text = function(ctx)
                  local lspkind = require 'lspkind'
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = lspkind.symbolic(ctx.kind, {
                      mode = 'symbol',
                    })
                  end
                  return icon .. ctx.icon_gap
                end,

                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
              label = {
                text = function(ctx)
                  return require('colorful-menu').blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require('colorful-menu').blink_components_highlight(ctx)
                end,
              },
            },
            treesitter = { 'lsp' },
          },
        },
      },
      keymap = {
        preset = 'none',
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up' },
        ['<C-f>'] = { 'scroll_documentation_down' },
        ['<S-CR>'] = { 'accept' },
        ['<esc>'] = { 'cancel', 'fallback' },
        ['<Tab>'] = {
          function(cmp)
            local luasnip = require 'luasnip'
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
              cmp.snippet_forward()
            else
              return false
            end
            return true
          end,
          'fallback',
        },
        ['<S-Tab>'] = {
          function(cmp)
            local luasnip = require 'luasnip'
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
              cmp.snippet_backward()
            else
              return false
            end
            return true
          end,
          'fallback',
        },
        ['<C-p>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
        -- ['<C-m>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      sources = {
        default = function()
          if require('cmp_dap').is_dap_buffer() then
            return { 'dap', 'snippets', 'buffer' }
          end
          return { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' }
        end,
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          dap = {
            name = 'dap',
            module = 'blink.compat.source',
          },
        },
      },
      cmdline = {
        enabled = false,
        keymap = {
          preset = 'none',
          ['<Tab>'] = { 'show', 'accept', 'fallback' },
          ['<Up>'] = { 'select_prev', 'fallback' },
          ['<Down>'] = { 'select_next', 'fallback' },
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<C-j>'] = { 'select_next', 'fallback' },
        },
        completion = { menu = { auto_show = true } },
        sources = {},
      },
      signature = {
        enabled = true,
        window = {
          border = 'single',
        },
      },
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)
    end,
  },
}
