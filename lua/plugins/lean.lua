return {
  {
    'Julian/lean.nvim',
    enabled = false,
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },

    opts = {
      mappings = true,
    }
  }
}
