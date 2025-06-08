return {
  {
    "tomtomjhj/vscoq.nvim",
    enabled = function()
      return false --vim.fn.executable("opam") == 1
    end,
    config = function()
      local opam_bin_path = vim.fn.system { 'opam', 'var', 'bin' }
      local p = opam_bin_path:gsub("[\r\n]", "") .. '/vscoqtop'
      require("vscoq").setup {
        vscoq = {
          completion = {
            enable = true
          }
        },
        lsp = {
          on_attach = function(client, bufnr)
            -- In manual mode, use ctrl-alt-{j,k,l} to step.
            vim.keymap.set({ 'n', 'i' }, '<C-D-j>', '<Cmd>VsCoq stepForward<CR>', { buffer = bufnr })
            vim.keymap.set({ 'n', 'i' }, '<C-D-k>', '<Cmd>VsCoq stepBackward<CR>', { buffer = bufnr })
            vim.keymap.set({ 'n', 'i' }, '<C-D-l>', '<Cmd>VsCoq interpretToPoint<CR>', { buffer = bufnr })
          end,
          cmd = { p }
        }
      }
    end
  },
  {
    'whonore/Coqtail'
  }
}
