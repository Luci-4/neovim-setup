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
            vim.api.nvim_command('bdelete! ' .. bufnr)
        end
    end

    -- If terminal buffer doesn't exist, open a new terminal
    if not terminal_exists then
        -- Terminal buffer exists, close it
        vim.cmd('botright split | terminal') -- Open terminal if closed
    end
end
map("n", "<leader>t", "<cmd>lua toggle_terminal()<CR>" , { noremap = true, silent = true })
