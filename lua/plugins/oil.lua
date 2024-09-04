return {
  {
    'stevearc/oil.nvim',
    enabled = false,
    opts = {
      columns = {
        'icon',
        'size',
        'permissions',
      },
      delete_to_trash = true,
      experimental_watch_for_changes = true,
      skip_confirm_for_simple_edits = true,
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
