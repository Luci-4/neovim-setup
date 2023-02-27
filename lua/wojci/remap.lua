vim.g.mapleader = " "
vim.keymap.set("n", "<leader>te", vim.cmd.Ex)
vim.keymap.set({"n", "i", "v"}, "<c-z>", vim.cmd.undo)

vim.keymap.set('n', '<M-l>', function()
  vim.cmd('bprev')
end)
-- vim.keymap.set("n", "<M-h>", "<c-^>")
-- vim.keymap.set("i", "<c-v>", "p")
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- window navigation
vim.keymap.set('n', '<c-h>', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set('n', '<c-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('n', '<c-k>', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set('n', '<c-l>', [[<Cmd>wincmd l<CR>]], opts)
