return {
  {
    "thenullvek/deepforest.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("deepforest").setup({})
    end,
    init = function()
      vim.cmd.colorscheme("deepforest")
    end
  }
}
