require 'vim_options'
require 'autocmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local secretpath = vim.fn.stdpath 'config' .. '/lua/secret.lua'
if vim.uv.fs_stat(secretpath) then
  require 'secret'
end

-- Detect the layout if we are on darwin.
local user_os_name = vim.uv.os_uname().sysname
if user_os_name == 'Darwin' then
  if vim.fn.executable 'kbdinfo' == 1 then
    local kbdstr = vim.fn.system 'kbdinfo'
    if string.sub(kbdstr, 1, 2) == 'US' then
      vim.g.us_layout = 1
    else
      vim.g.us_layout = 0
    end
  end
end

require 'keymap'
require 'start'

if vim.g.neovide then
  require 'neovide'
end

-- Setup for ocp-indent
if vim.fn.executable 'opam' == 1 then
  local opam_share_path = vim.fn.system { 'opam', 'var', 'share' }
  if vim.v.shell_error == 0 then
    local p = opam_share_path:gsub('[\r\n]', '')
    vim.opt.rtp:append(p .. '/ocp-indent/vim')
  end
end

-- Load configuration script in vimscript.
vim.cmd('source ' .. vim.fn.stdpath 'config' .. '/init2.vim')

-- Time to configure LSP servers
local lspconfig = require 'lspconfig'
vim.lsp.config(
  '*',
  ---@type vim.lsp.Config
  {
    capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig.default_capabilities),
    on_attach = lspconfig.on_attach,
    root_markers = { '.git' },
  }
)
vim.lsp.enable {
  'luals',
  'clangd',
  'neocmake',
  'pyright',
  'bashls',
  --"vscoqtop",
}
