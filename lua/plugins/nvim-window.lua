return {
  {
    'yorickpeterse/nvim-window',
    keys = {
      { ',', "<cmd>lua require('nvim-window').pick()<cr>", desc = 'nvim-window: Jump to window' },
    },
    config = function()
      require('nvim-window').setup {
        hint_hl = 'Bold',
      }
    end,
  },
  --[[ {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    keys = {
      { ',', "<cmd>lua require('window-picker').pick_window()<cr>", desc = 'Jump to window' },
    },
    config = function()
      require 'window-picker'.setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal', "quickfix" },
          },
        },
      })
    end,
  }, ]]
}
