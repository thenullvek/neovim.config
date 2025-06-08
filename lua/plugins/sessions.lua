return {
  {
    'stevearc/resession.nvim',
    config = function()
      local blacklist = { "lean:", "coq:", "neo:" }
      require("resession").setup({
        buf_filter = function(bufnr)
          for _, prefix in ipairs(blacklist) do
            if vim.startswith(vim.api.nvim_buf_get_name(bufnr), prefix) then
              return false
            end
          end
        end,
      })
    end,
    init = function()
      local resession = require("resession")
      vim.keymap.set("n", "<localleader>ss", resession.save, { desc = "[S]ession [S]ave" })
      vim.keymap.set("n", "<localleader>sl", resession.load, { desc = "[S]ession [L]oad" })
      vim.keymap.set("n", "<localleader>sd", resession.delete, { desc = "[S]ession [D]elete" })
    end
  }
}
