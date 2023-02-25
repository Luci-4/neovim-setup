vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set({"n", "i", "v"}, "<c-z>", vim.cmd.undo)

vim.keymap.set('n', '<M-l>', function()
  vim.cmd('bprev')
end)
vim.keymap.set("n", "<M-h", "<c-^>")
