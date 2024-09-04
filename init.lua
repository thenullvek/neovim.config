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

-- Load configuration script in vimscript.
vim.cmd("source " .. vim.fn.stdpath("config") .. "/init2.vim")
