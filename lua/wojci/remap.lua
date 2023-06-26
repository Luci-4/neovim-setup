vim.g.mapleader = " "
vim.keymap.set("n", "<leader>te", vim.cmd.Ex)
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
