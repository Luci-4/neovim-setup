require("wojci.set")
require("wojci.remap")
require("wojci.netrw")

-- vim.cmd("set fillchars=stl:")

vim.cmd("set fillchars=stl:\\ ")
vim.cmd('highlight clear ColorColumn')


vim.api.nvim_buf_set_option(0, "syntax", "on")

-- Create a new file and save it
vim.api.nvim_set_keymap("n", "o", "%:w<CR>:buffer #<CR>", {})

-- Create a new directory
local function printu()
    print(vim.fn.expand('%:p'))
end
vim.api.nvim_set_keymap("n", "fd", "d", {})

local function openNtree()
    vim.cmd('Ntree')
end

vim.cmd[[
    augroup MyAutocmds
        autocmd!
        autocmd VimEnter * Ntree
    augroup END
]]

-- Rename file

-- vim.api.nvim_set_keymap("n", "l", "i", {})

-- Remove file or directory
vim.cmd([[
    augroup filetypedetect
        au BufRead,BufNewFile *.cpp setfiletype cpp
        au BufRead,BufNewFile *.hpp setfiletype cpp
    augroup END
]])
