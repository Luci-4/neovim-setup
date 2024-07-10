require("wojci.spectroscope.spectroscope_filesystem")

vim.api.nvim_exec([[
highlight link CurrentLine Visual
]], false)

local current_line = 2

local function highlight_current_line(buf, line)
    vim.api.nvim_buf_clear_namespace(buf, -1, 1, -1)
    vim.api.nvim_buf_add_highlight(buf, -1, 'CurrentLine', line, 0, -1)
end

function move_highlight(buf, direction)
    local line_count = vim.api.nvim_buf_line_count(buf)
    current_line = current_line + direction
    if current_line < 2 then
        current_line = 2
    elseif current_line > line_count then
        current_line = line_count
    end
    highlight_current_line(buf, current_line - 1)
end

function display_search_list(callback)
    local function create_scratch_buffer()
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
        vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
        vim.api.nvim_buf_set_option(buf, 'modifiable', true)
        vim.cmd('vsplit')
        vim.api.nvim_win_set_buf(0, buf)
        return buf
    end

    local buf = create_scratch_buffer()
    vim.cmd('autocmd BufEnter <buffer> setlocal cursorline')

    local function display_list()
        local list = callback(vim.fn.getline(1))
        vim.api.nvim_buf_set_lines(buf, 1, -1, false, {})
        for _, element in ipairs(list) do
            vim.api.nvim_buf_set_lines(buf, -1, -1, false, {element})
        end
        current_line = 2
        highlight_current_line(buf, current_line - 1)
    end

    vim.api.nvim_create_augroup('SpecialBufferKeyPress', { clear = true })
    vim.api.nvim_create_autocmd('CursorMovedI', {
        group = 'SpecialBufferKeyPress',
        buffer = buf,
        callback = function()
            display_list()
        end,
    })

    vim.api.nvim_buf_set_keymap(buf, 'i', '<M-j>', '<Cmd>lua move_highlight(' .. buf .. ', 1)<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'i', '<M-k>', '<Cmd>lua move_highlight(' .. buf .. ', -1)<CR>', { noremap = true, silent = true })

    vim.api.nvim_buf_set_keymap(buf, 'n', '<M-j>', '<Cmd>lua move_highlight(' .. buf .. ', 1)<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'n', '<M-k>', '<Cmd>lua move_highlight(' .. buf .. ', -1)<CR>', { noremap = true, silent = true })
    
    vim.api.nvim_create_autocmd('TextChangedI', {
        group = 'SpecialBufferKeyPress',
        buffer = buf,
        callback = function()
            current_line = 2
            highlight_current_line(buf, current_line - 1)
        end,
    })

    -- Prevent cursor from leaving the first line in normal mode
    vim.api.nvim_create_autocmd('CursorMoved', {
        group = 'SpecialBufferKeyPress',
        buffer = buf,
        callback = function()
            if vim.api.nvim_get_mode().mode == 'n' then
                local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
                if row > 1 then
                    vim.api.nvim_win_set_cursor(0, {1, 0})
                end
            end
        end,
    })
end

