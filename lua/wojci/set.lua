vim.cmd('colorscheme shado')	
vim.g.mapleader = " "					-- sets leader key
vim.g.netrw_banner = 0					-- gets rid of the annoying banner for netrw
vim.g.netrw_browse_split=4				-- open in prior window
vim.g.netrw_altv = 1					-- change from left splitting to right splitting
vim.g.netrw_liststyle=3					-- tree style view in netrw
vim.g.netrw_tree = 1
vim.opt.title = true					-- show title
vim.opt.titleold = "asdf"
-- vim.opt.titlestring = [[eeee%t – %{fnamemodify(getcwd(), ':t')}]]
-- vim.cmd('set path+=**')					-- search current directory recursively

vim.opt.syntax = "ON"
vim.opt.backup = false
vim.opt.compatible = false				-- turn off vi compatibility mode
vim.opt.number = true					-- turn on line numbers
vim.opt.relativenumber = true			-- turn on relative line numbers
vim.opt.mouse = 'a'						-- enable the mouse in all modes
vim.opt.ignorecase = true				-- enable case insensitive searching
vim.opt.smartcase = true				-- all searches are case insensitive unless there's a capital letter
vim.opt.incsearch = true				-- enable incremental searching
vim.opt.tabstop = 4						-- tabs=4spaces
vim.opt.shiftwidth = 4
vim.opt.fileencoding = "utf-8"			-- encoding set to utf-8
vim.opt.showtabline = 2					-- always show the tab line
vim.opt.laststatus = 2					-- always show statusline
vim.opt.signcolumn = "auto"
vim.opt.expandtab = false				-- expand tab 
vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.showmode = true
vim.opt.termguicolors = true
vim.cmd('filetype plugin on')			-- set filetype 
vim.cmd('set wildmenu')					-- enable wildmenu
vim.opt.splitbelow = true				-- split go below
vim.opt.splitright = true				-- vertical split to the right
--statusline
vim.cmd "highlight StatusFile guibg=#bd93f9 guifg=#1d2021"
vim.cmd "highlight StatusModified guibg=#1d2021 guifg=#d3869b"
vim.cmd "highlight StatusBuffer guibg=#98971a guifg=#1d2021"
vim.cmd "highlight StatusLocation guibg=#458588 guifg=#1d2021"
vim.cmd "highlight StatusNorm guibg=none guifg=white"
vim.o.statusline = " "
				.. "%#StatusNorm#"
				.. " "
				.. "﬘ "
				.. "%n"
				.. " "
				.. "  "
				.. "%F"
				.. " "
				.. "%#StatusModified#"
				.. " "
				.. "%m"
				.. " "
				.. ""
				.. " "
				.. "%l,%c"
				.. " "
				.. "%#StatusNorm#"
				.. "%="
function StatusLineHighlight()

	return  " "
				.. "%#StatusFile#"
				.. " "
				.. "﬘ "
				.. "%n"
				.. " "
				.. "  "
				.. "%F"
				.. " "
				.. "%#StatusModified#"
				.. " "
				.. "%m"
				.. " "
				.. ""
				.. " "
				.. "%l,%c"
				.. " "
				.. "%#StatusNorm#"
				.. "%="
end

function StatusLineReset()
    return " "
				.. "%#StatusNorm#"
				.. " "
				.. "﬘ "
				.. "%n"
				.. " "
				.. "  "
				.. "%F"
				.. " "
				.. "%#StatusModified#"
				.. " "
				.. "%m"
				.. " "
				.. ""
				.. " "
				.. "%l,%c"
				.. " "
				.. "%#StatusNorm#"
				.. "%="
end

-- TODO not working
-- Function to check if the buffer has a cursor
local function has_cursor()
    local current_win = vim.api.nvim_get_current_win()
    local current_buf = vim.api.nvim_win_get_buf(current_win)
    local cursor = vim.api.nvim_win_get_cursor(current_win)
    return cursor[1] ~= 0 or cursor[2] ~= 0 or vim.api.nvim_buf_get_option(current_buf, 'buftype') == ''
end

-- Function to update status line
local function update_statusline()
    if has_cursor() then
		StatusLineHighlight()
    else
		StatusLineReset()
    end
end

-- Set status line initially
update_statusline()
vim.cmd([[
	autocmd WinLeave * setlocal statusline=%!v:lua.StatusLineReset()
	autocmd BufWinEnter * setlocal statusline=%!v:lua.StatusLineHighlight()
]])


vim.wo.colorcolumn = ''
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true


vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
