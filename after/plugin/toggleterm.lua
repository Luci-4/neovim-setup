local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "echo \"hello\"", hidden=true, close_on_exit = false})

function _get_command()
    local path = vim.api.nvim_buf_get_name(0)
    local filetype = vim.bo.filetype
    local c_tbl =
    {
        ["python"] = function() return string.format("python %s", vim.api.nvim_buf_get_name(0)) end
    }
    return c_tbl[filetype]()

end
function _run_file()
    -- lazygit.cmd = string.format("python %s", path)
    -- lazygit.cmd = "echo \"hello fucker\""
    local command = _get_command()
    vim.cmd("ToggleTerm")
    vim.cmd(string.format("TermExec cmd=\"%s\"", command))
    -- lazygit:toggle()
end
vim.keymap.set("n", "<leader>g", "<cmd>lua _run_file()<CR>")
-- vim.api.nvim_set_keymap("n", "<C-`>", "<cmd>ToggleTerm<CR>", {"Terminal"})
-- vim.keymap.set("n", "<C-`>", "<cmd>ToggleTerm<CR>")
-- vim.keymap.set("n", "<C-`>", "<cmd>ToggleTerm<CR>")
-- print(type(Terminal))
-- print(Terminal)
-- local coderun = Terminal:new({ cmd = "\"test.bat\"" })
-- print(type(coderun))
-- vim.keymap.set('n', '<S-CR>', coderun:toggle())

