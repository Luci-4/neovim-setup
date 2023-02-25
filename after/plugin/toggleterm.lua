local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "echo \"hello\"", close_on_exit = false})

function _lazygit_toggle()
    local path = vim.api.nvim_buf_get_name(0)
    lazygit.cmd = string.format("python %s", path)

    lazygit:toggle()
end
vim.keymap.set("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>")
-- vim.api.nvim_set_keymap("n", "<C-`>", "<cmd>ToggleTerm<CR>", {"Terminal"})
-- vim.keymap.set("n", "<C-`>", "<cmd>ToggleTerm<CR>")
-- vim.keymap.set("n", "<C-`>", "<cmd>ToggleTerm<CR>")
-- print(type(Terminal))
-- print(Terminal)
-- local coderun = Terminal:new({ cmd = "\"test.bat\"" })
-- print(type(coderun))
-- vim.keymap.set('n', '<S-CR>', coderun:toggle())

