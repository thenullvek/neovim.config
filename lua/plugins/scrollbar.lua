return {
  {
    'petertriho/nvim-scrollbar',
    enabled = false,
    config = function()
      require('scrollbar').setup({
        excluded_filetypes = {
          "lazy",
          "mason",
          "oil",
          "neo-tree",
        }
      })
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },
}
