return {
  {
    'Darazaki/indent-o-matic',
    config = function()
      require('indent-o-matic').setup {
        max_lines = 1024,
      }
    end,
  },
}
