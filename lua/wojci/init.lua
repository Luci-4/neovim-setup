require("wojci.remap")
require("wojci.set")

-- vim.cmd("set fillchars=stl:")
vim.cmd("set fillchars=stl:\\ ")
vim.cmd('highlight clear ColorColumn')
vim.wo.colorcolumn = ''
vim.cmd('colorscheme quantum')

vim.api.nvim_buf_set_option(0, "syntax", "on")
