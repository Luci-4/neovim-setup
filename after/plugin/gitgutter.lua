-- vim.cmd([[
--   augroup GitGutter
--     autocmd!
--     autocmd CursorHold,CursorHoldI * GitGutter
--   augroup END
-- ]])

-- vim.api.nvim_command('autocmd BufWritePost * GitGutter')
vim.g.gitgutter_enabled = 0
vim.api.nvim_set_keymap('n', '<leader>git', '<cmd>GitGutterToggle<CR>', { noremap = true })
