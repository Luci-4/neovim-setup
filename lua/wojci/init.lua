require("wojci.set")
require("wojci.remap")
require("wojci.netrw")
require("wojci.lsp")
require("wojci.search")

vim.opt.path:append('**')
vim.o.wildmenu = true

vim.o.wildmode = "list:full"


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
function openPopup()
    -- Define the content for the popup window
    local popup_content = {
        "This is a popup window!",
        "You can put whatever content you want here.",
        "For example, a list of items:",
        "1. Item 1",
        "2. Item 2",
        "3. Item 3"
    }

    -- Calculate the position for the popup window
    local win_width = vim.api.nvim_win_get_width(0)
    local win_height = vim.api.nvim_win_get_height(0)
    local popup_width = 40
    local popup_height = #popup_content + 2
    local row = math.floor((win_height - popup_height) / 2)
    local col = math.floor((win_width - popup_width) / 2)

    -- Open a new buffer for the popup content
    local popup_buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(popup_buffer, 0, -1, false, popup_content)

    -- Define the options for the popup window
    local popup_options = {
        style = "minimal",
        relative = "editor",
        width = popup_width,
        height = popup_height,
        row = row,
        col = col,
        focusable = true,  -- Prevent focusing other buffers
        border = "single"
    }

    -- Open the popup window
    local popup_window = vim.api.nvim_open_win(popup_buffer, true, popup_options)
end

vim.api.nvim_set_keymap(
    'n', 
    '<leader>b', 
    '<cmd>lua openPopup()<CR>', 
    { noremap = true, silent = true }
)
