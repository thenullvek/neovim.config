return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          section_separators = { left = '', right = '' },
          component_separators = { left = '|', right = '|' },
          globalstatus = true,
        },
        sections = {
          lualine_x = { 'encoding', { 'fileformat', symbols = { unix = '' } }, 'filetype' },
        },
      }
    end,
  },
}
