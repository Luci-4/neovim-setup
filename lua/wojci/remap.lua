function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Open netrw in 25% split in tree view
-- map("n", "<leader>e", ":25Lex<CR>")
local function toggle_ntree()
    local view = vim.fn.winsaveview() -- Save current view
    vim.cmd(":botright vsplit | Ntree<CR>") -- Toggle NvimTree
    vim.fn.winrestview(view) -- Restore view
end

function PrintBufferNames()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        print(bufname)
    end
end

-- Function to toggle terminal
function toggle_terminal()
    local terminal_exists = false
    local buffername_pattern =  "^term://"

    -- Iterate over all buffers
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        -- Check if the buffer name indicates a terminal
        if string.match(bufname, buffername_pattern) then
            terminal_exists = true
            -- Close the terminal buffer
            vim.api.nvim_command('bdelete ' .. bufnr)
        end
    end

    -- If terminal buffer doesn't exist, open a new terminal
    if not terminal_exists then
        -- Terminal buffer exists, close it
        vim.cmd('botright split | terminal') -- Open terminal if closed
    end
end
map("n", "<leader>t", "<cmd>lua toggle_terminal()<CR>" , { noremap = true, silent = true })


map("n", "<leader>vs", ":vsplit<CR>")
-- Visual Maps
map("v", "<leader>y", "\"hy:%s/<C-r>h//g<left><left>")	-- Replace all instances of highlighted words 
map("v", "J", ":m '>+1<CR>gv=gv")						-- Move current line down
map("v", "K", ":m '>-2<CR>gv=gv")						-- Move current line up

-- TODO: think about those tabs
-- map("n", "<leader>t", ":tabnew<CR>")				-- space+t creates new tab
-- map("n", "<leader>tx", ":tabclose<CR>")				-- space+tx closes current tab
-- map("n", "<leader>pt", ":tabprevious<CR>")			-- space+pt moves to previous tab
-- map("n", "<leader>nt", ":tabnext<CR>")				-- space+nt moves to next tab
-- not working:
-- map("n", "<leader>r", vim.cmd("source ~\\AppData\\Local\\nvim\\init.lua <CR>"))	-- reload neovim config


-- vim.keymap.set("n", "<leader>te", vim.cmd.Ex)
vim.keymap.set({"n", "i", "v"}, "<c-z>", vim.cmd.undo)

-- vim.keymap.set("i", "<c-v>", "p")
vim.keymap.set("n", "<leader><leader>", "<c-^>")

local function is_last_buffer_on_right()
  local current_win_id = vim.api.nvim_get_current_win()
  local current_tabpage = vim.api.nvim_get_current_tabpage()
  local window_ids = vim.api.nvim_tabpage_list_wins(current_tabpage)

  for i = 1, #window_ids do
    if window_ids[i] ~= current_win_id then
      local win_info = vim.api.nvim_win_get_config(window_ids[i])
      if win_info.relative ~= '' and win_info.relative ~= 'editor' then
        return false
      end
    end
  end

  return true
end

function _increase_size()
	vim.cmd("res +1")
end

function _decrease_size()
	vim.cmd("res -1")
end

function _increase_width()
    vim.cmd("wincmd >")
end

function _decrease_width()
    vim.cmd("wincmd <")
end
-- window navigation
vim.keymap.set('n', '<M-h>', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set('n', '<M-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('n', '<M-l>', [[<Cmd>wincmd l<CR>]])
vim.keymap.set('n', '<M-k>', [[<Cmd>wincmd k<CR>]], opts)

vim.keymap.set('n', '<M-=>', [[<Cmd>wincmd ><CR>]], opts)
vim.keymap.set('n', '<M-->', [[<Cmd>wincmd <<CR>]], opts)

vim.keymap.set('n', '<leader>=', '[[<Cmd>wincmd =<CR>]]', {})
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set('n', '<c-k>', "<cmd>lua _increase_size()<CR>", {})
vim.keymap.set('n', '<c-j>', "<cmd>lua _decrease_size()<CR>", {})
vim.keymap.set("n", "<C-M-j>", "<C-e>", {})
vim.keymap.set("n", "<C-M-k>", "<C-Y>", {})

vim.keymap.set("n", "<c-l>", "<cmd>lua _increase_width()<CR>", {})
vim.keymap.set("n", "<c-h>", "<cmd>lua _decrease_width()<CR>", {})

--vim.keymap.set('n', '<c-<kMinus>>', vim.cmd("res -1"), {})
-- TODO: add vertical split and maybe change those
-- also there is a bug where when typing < it takes a while to move cursor forward 

-- terminal
vim.keymap.set({"i", "t"}, 'jk', [[<C-\><C-n>]])
vim.keymap.set({"i", "t"}, 'kj', [[<C-\><C-n>]])
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
