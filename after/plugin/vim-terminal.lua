function _run_bash()
    vim.cmd("Terminal \"C:\\Program Files\\Git\\git-bash.exe\"")
end
vim.keymap.set("n", "<leader>tt", "<cmd>lua _run_bash()<CR>")
