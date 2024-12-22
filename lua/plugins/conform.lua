return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<localleader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    config = function(opts)
      local slow_fmts = {}
      local ignored_filetypes = { "c", "cpp" }
      require("conform").setup({
        formatters = {
          clang_format = {
            prepend_args = { '--style=file', '--fallback-style=LLVM' },
          },
        },
        formatters_by_ft = {
          json = { "jq" }
        },
        format_on_save = function(bufnr)
          if slow_fmts[vim.bo[bufnr].filetype] or vim.tbl_contains(ignored_filetypes, vim.bo[bufnr].filetype) then
            return
          end
          local function on_format(err)
            if err and err:match("timeout$") then
              slow_fmts[vim.bo[bufnr].filetype] = true
            end
          end
          return { timeout_ms = 200, lsp_format = "fallback" }, on_format
        end,

        format_after_save = function(bufnr)
          if not slow_fmts[vim.bo[bufnr].filetype] or vim.tbl_contains(ignored_filetypes, vim.bo[bufnr].filetype) then
            return
          end
          return { lsp_format = "fallback" }
        end,
      })
      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        require('conform').format { async = true, lsp_format = 'fallback', range = range }
      end, { range = true })
    end,
  },
}
