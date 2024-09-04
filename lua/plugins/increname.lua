return {
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup({})
      vim.keymap.set("n", "<leader>rn", ":IncRename ", {desc = "[R]e[n]ame"})
      vim.keymap.set("n", "<leader>rc", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "[R]ename [C]ursor" })
    end,
  }
}
