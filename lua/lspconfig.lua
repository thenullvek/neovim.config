local M = {
  default_capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), {
    textDocument = {
      completion = {
        dynamicRegistration = false,
        completionItem = {
          snippetSupport = true,
          commitCharactersSupport = true,
          deprecatedSupport = true,
          preselectSupport = true,
          tagSupport = {
            valueSet = {
              1, -- Deprecated
            },
          },
          insertReplaceSupport = true,
          resolveSupport = {
            properties = {
              'documentation',
              'additionalTextEdits',
              'insertTextFormat',
              'insertTextMode',
              'command',
            },
          },
          insertTextModeSupport = {
            valueSet = {
              1, -- asIs
              2, -- adjustIndentation
            },
          },
          labelDetailsSupport = true,
        },
        contextSupport = true,
        insertTextMode = 1,
        completionList = {
          itemDefaults = {
            'commitCharacters',
            'editRange',
            'insertTextFormat',
            'insertTextMode',
            'data',
          },
        },
      },
    },
  }),
}

---@param client vim.lsp.Client
---@param buf integer
function M.on_attach(client, buf)
  local builtin = require 'telescope.builtin'
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
  end

  map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('gr', builtin.lsp_references, '[G]oto [R]eferences')
  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  map('<leader>wfl', vim.lsp.buf.list_workspace_folders, '[W]orkspace [F]olders [L]ist')
  map('<leader>wfa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [F]olders [A]dd')
  map('<leader>wfr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [F]older [R]emove')

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }, { bufnr = buf })
    end, '[T]oggle [H]ints')
    client.server_capabilities.semanticTokensProvider = nil
  end

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, buf) then
    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
      end,
    })
  end
end

return M
