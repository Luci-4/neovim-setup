local Terminal  = require('toggleterm.terminal').Terminal

function _get_command()
    local path = vim.api.nvim_buf_get_name(0)
    local filetype = vim.bo.filetype
    local c_tbl =
    {
        ["python"] = function() return string.format("python %s", vim.api.nvim_buf_get_name(0)) end
    }
    return c_tbl[filetype]()

end
function _toggle_term()
    local command = _get_command()
    vim.cmd("ToggleTerm")
    vim.cmd(string.format("TermExec cmd=\"%s\"", command))
    -- lazygit:toggle()
end
vim.keymap.set("n", "<leader><Enter>", "<cmd>lua _toggle_term()<CR>")
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- vim.api.nvim_set_keymap("n", "<C-`>", "<cmd>ToggleTerm<CR>", {"Terminal"})
-- vim.keymap.set("n", "<C-`>", "<cmd>ToggleTerm<CR>")
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>")
-- print(type(Terminal))
-- print(Terminal)
-- local coderun = Terminal:new({ cmd = "\"test.bat\"" })
-- print(type(coderun))
-- vim.keymap.set('n', '<S-CR>', coderun:toggle())

