require 'vim_options'
require 'keymap'
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
if not vim.uv.fs_stat(secretpath) then
  require 'secret'
end

require 'start'

if vim.g.neovide then
  require 'neovide'
end

-- Setup for ocp-indent
local opam_share_path = vim.fn.system { 'opam', 'var', 'share' }
if vim.v.shell_error == 0 then
  local p = opam_share_path:gsub("[\r\n]", "")
  vim.opt.rtp:append(p .. "/ocp-indent/vim")
end

-- Load configuration script in vimscript.
vim.cmd("source " .. vim.fn.stdpath("config") .. "/init2.vim")
