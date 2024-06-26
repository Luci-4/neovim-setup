-- Define netrw file manipulation mappings
vim.g.netrw_winsize = 2
function toggle_netrw()

    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local bufnr = vim.api.nvim_win_get_buf(win)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname ~= '' and bufname:find('Netrw') then
            -- vim.cmd(tostring(bufnr) .. 'q')
            vim.api.nvim_buf_delete(bufnr, { force = true })
            return true
        end
    end
    vim.cmd('botright vsplit | Ntree')
end

map("n", "<leader>e",'<cmd>lua toggle_netrw()<CR>', { noremap = true, silent = true })
-- Human-readable files sizes
vim.g.netrw_sizestyle = "H"
vim.g.netrw_browse_split = 0

vim.cmd([[
    autocmd FileType netrw nmap <buffer> l i
    autocmd FileType netrw nmap <buffer> i R
    autocmd FileType netrw nmap <buffer> <C-r> <C-l>
    autocmd FileType netrw nmap <buffer> <C-o> x
    autocmd FileType netrw nmap <buffer> <C-l> <cmd>lua _increase_width()<CR>
    autocmd FileType netrw nmap <buffer> <TAB> mf
    autocmd FileType netrw nmap <buffer> <Leader><TAB> mF
    autocmd FileType netrw nmap <buffer> gh qf
    autocmd FileType netrw nmap <buffer> y mc
    autocmd FileType netrw nmap <buffer> O d
    autocmd FileType netrw nmap <buffer> <leader>d md // diff


]])
-- vim.keymap.set("n", "<c-l>", "<cmd>lua _increase_width()<CR>", {})
-- autocmd FileType netrw nmap <buffer> o %

vim.cmd([[
    autocmd FileType netrw nmap <buffer> a <NOP>
    autocmd FileType netrw nmap <buffer> - <NOP>
    autocmd FileType netrw nmap <buffer> c <NOP>
    autocmd FileType netrw nmap <buffer> C <NOP>
    autocmd FileType netrw nmap <buffer> t <NOP>
    autocmd FileType netrw nmap <buffer> o <NOP>

]])
-- clear all binds

vim.api.nvim_set_keymap('n', 'o', 'o', { noremap = true, silent = true })
