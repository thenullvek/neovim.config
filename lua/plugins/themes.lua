return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    enabled = false,
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      require('github-theme').setup {
        options = {
          dim_inactive = true,
          styles = {
            comments = 'italic',
            keywords = 'bold',
            types = 'italic,bold',
          },
          darken = {
            floats = true,
            sidebars = {
              enable = true,
            },
          },
          palettes = {
            github_dark_dimmed = {
              red = '#2596be',
            },
          },
        },
      }
    end,
    init = function()
      vim.cmd.colorscheme 'github_dark_dimmed'
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    enabled = false,
    config = function()
      require('nightfox').setup {
        options = {
          dim_inactive = true,
          styles = {
            comments = 'italic',
            keywords = 'bold',
            types = 'italic,bold',
          },
        },
      }
    end,
    init = function()
      vim.cmd.colorscheme 'nightfox'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    enabled = false,
    config = function()
      require('kanagawa').setup {
        compile = true,
        typeStyle = { bold = true, italic = true },
        transparent = false,
        theme = 'dragon',
        dimInactive = true,
      }
    end,
    init = function()
      vim.cmd.colorscheme 'kanagawa-dragon'
    end,
  },
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    enabled = true,
    init = function()
      vim.cmd.colorscheme "modus"
    end
  }
}
