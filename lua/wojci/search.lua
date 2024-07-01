vim.api.nvim_exec([[
highlight link CurrentLine Visual
]], false)

local current_line = 2

local function escapePattern(s)
    return s:gsub("([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
end

local function removeFromString(originalString, substringToRemove)
    local escapedSubstring = escapePattern(substringToRemove)
    local startIdx, endIdx = string.find(originalString, escapedSubstring)
    if startIdx then
        return originalString:sub(1, startIdx - 1) .. originalString:sub(endIdx + 1)
    else
        return originalString
    end
end

local function stringContains(s, sub)
    return string.find(s:lower(), sub:lower(), 1, true) ~= nil
end

local search_cache = {}

local function preload_cache(root_dir)
    local file_paths = {}

    local function search_directory(dir)
        local files = vim.fn.readdir(dir)
        for _, file in ipairs(files) do
            local file_path = dir .. '/' .. file
            local file_type = vim.fn.getftype(file_path)
            if file_type == 'dir' then
                if file ~= '.' and file ~= '..' then
                    search_directory(file_path)
                end
            elseif file_type == 'file' then
                table.insert(file_paths, file_path)
            end
        end
    end

    search_directory(root_dir)
    search_cache[root_dir] = file_paths
end

local function recursive_search(root_dir, query)
    local query_lower = query:lower()

    if not search_cache[root_dir] then
        preload_cache(root_dir)
    end

    local file_paths = {}
    for _, file_path in ipairs(search_cache[root_dir]) do
        if stringContains(file_path, query_lower) then
            local strippedPath = removeFromString(file_path, root_dir)
            table.insert(file_paths, strippedPath)
        end
    end

    return file_paths
end

function search_for_files(query)
    local root_dir = vim.fn.getcwd()
    root_dir = root_dir:gsub("\\", "/")
    local result_paths = recursive_search(root_dir, query)
    return result_paths
end

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
    
    -- Move highlight to the first item after inserting a character in the first line
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

preload_cache(vim.fn.getcwd():gsub("\\", "/"))
