local function escapePattern(s)
    return s:gsub("([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
end

-- Remove a substring from a string
local function removeFromString(originalString, substringToRemove)
    local escapedSubstring = escapePattern(substringToRemove)
    local startIdx, endIdx = string.find(originalString, escapedSubstring)
    if startIdx then
        return originalString:sub(1, startIdx - 1) .. originalString:sub(endIdx + 1)
    else
        return originalString
    end
end

-- Check if a string contains a substring (case-insensitive)
local function stringContains(s, sub)
    return string.find(s:lower(), sub:lower(), 1, true) ~= nil
end

-- Cache table to store search results
local search_cache = {}

-- Function to preload cache with all file paths
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

-- Recursive search for files matching a query in a directory
local function recursive_search(root_dir, query)
    local query_lower = query:lower()

    -- Check if results are cached and preload if necessary
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

-- Function to search for files matching a query
function search_for_files(query)
    local root_dir = vim.fn.getcwd()
    root_dir = root_dir:gsub("\\", "/")
    local result_paths = recursive_search(root_dir, query)
    return result_paths
end

-- Function to display search results in a buffer
function display_search_list(callback)
    -- Function to create a new scratch buffer
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

    -- Function to handle user input and trigger search
    local function display_list()
        local list = callback(vim.fn.getline(1))
        vim.api.nvim_buf_set_lines(buf, 1, -1, false, {})
        for _, element in ipairs(list) do
            vim.api.nvim_buf_set_lines(buf, -1, -1, false, {element})
        end
    end

    vim.api.nvim_create_augroup('SpecialBufferKeyPress', { clear = true })
    vim.api.nvim_create_autocmd('CursorMovedI', {
        group = 'SpecialBufferKeyPress',
        buffer = buf,
        callback = function()
            display_list()
        end,
    })
end

-- Preload cache on script initialization
preload_cache(vim.fn.getcwd():gsub("\\", "/"))
