-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require('oil').get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  {
    'stevearc/oil.nvim',
    config = function(opts)
      require('oil').setup {
        default_file_explorer = true,
        columns = {
          'icon',
          'size',
          'permissions',
          'mtime',
        },
        win_options = {
          signcolumn = 'yes:2',
          winbar = '%!v:lua.get_oil_winbar()',
        },
        delete_to_trash = true,
        experimental_watch_for_changes = true,
        skip_confirm_for_simple_edits = true,
      }
    end,
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'refractalize/oil-git-status.nvim',

    dependencies = {
      'stevearc/oil.nvim',
    },

    config = true,
  },
}
