-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jj', '<Esc>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', '<cmd>Trouble qflist toggle<cr>', { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', 'yh', '<C-w><C-s>', { desc = 'Split window horizontally' })
vim.keymap.set('n', 'yv', '<C-w><C-v>', { desc = 'Split window vertically' })
vim.keymap.set('n', 'qq', '<C-w><C-q>', { desc = 'Quit current window' })

-- Show keymap help
vim.keymap.set('n', 'H', '<cmd>WhichKey<cr>', { desc = 'Show keymap help', silent = true })
if vim.g.us_layout == 1 then
  vim.keymap.set('n', '|', '<cmd>Neotree toggle<cr>', { desc = 'Open file browser', silent = true })
else
  vim.keymap.set('n', 'ß', '<cmd>Neotree toggle<cr>', { desc = 'Open file browser', silent = true })
end
-- Toggle Terminal
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>", { desc = "[T]oggle Terminal" })
