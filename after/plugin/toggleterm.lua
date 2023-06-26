local Terminal = require('toggleterm.terminal').Terminal

function _run_in_toggle_term(command)

    vim.cmd("ToggleTerm")
    vim.cmd(string.format("TermExec cmd=\"%s\"", command))
end

function OplRun(configuration)
  if not configuration or configuration == "" then
    configuration = "."
  end
  _run_in_toggle_term('oplrun -v -p ' .. configuration)
end

vim.cmd('command! -nargs=? OplRun lua OplRun(<f-args>)')

-- TODO: add a separate run function for displayed buffer 
function _get_command()

    print(vim.bo.filetype)
    local path = vim.api.nvim_buf_get_name(0)
    local filetype = vim.bo.filetype
    local c_tbl =
    {
        ["python"] = function() return string.format("python %s", vim.api.nvim_buf_get_name(0)) end,
        ["c"] = function() return string.format("gcc -save-temps %s -o program && program", vim.api.nvim_buf_get_name(0)) end
    }
    return c_tbl[filetype]()

end
function _run_in_vim_cmd(command)
    vim.cmd(string.format(":!%s", command))
end

function _run_in_term()
    local command = _get_command()
    _run_in_toggle_term(command)
    -- lazygit:toggle()
end
vim.keymap.set("n", "<leader>9", "<cmd>OplRun<CR>")

vim.keymap.set("n", "<leader><Enter>", "<cmd>lua _run_in_term()<CR>")
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', '<C-M-h>', [[<Cmd>wincmd h<CR>]], opts)
  -- vim.keymap.set('t', '<C-M-j>', [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set('t', '<C-M-l>', [[<Cmd>wincmd l<CR>]], opts)
  -- vim.keymap.set('t', '<C-M-k>', [[<Cmd>wincmd k<CR>]], opts)
  -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

require("toggleterm").setup{
    autochdir = true,
    start_in_insert = false,
    auto_scroll = true,
}
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- vim.api.nvim_set_keymap("n", "<C-`>", "<cmd>ToggleTerm<CR>", {"Terminal"})
-- vim.keymap.set("n", "<C-`>", "<cmd>ToggleTerm<CR>")
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>")
vim.cmd[[autocmd! TermOpen term://* lua set_terminal_keymaps()]]
-- print(type(Terminal))
-- print(Terminal)
-- local coderun = Terminal:new({ cmd = "\"test.bat\"" })
-- print(type(coderun))
-- vim.keymap.set('n', '<S-CR>', coderun:toggle())

