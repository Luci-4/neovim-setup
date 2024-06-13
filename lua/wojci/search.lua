function escapePattern(s)
    return s:gsub("([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
end

function removeFromString(originalString, substringToRemove)
    local escapedSubstring = escapePattern(substringToRemove)
    local startIdx, endIdx = string.find(originalString, escapedSubstring)
    if startIdx then
        local modifiedString = string.sub(originalString, 1, startIdx - 1) .. string.sub(originalString, endIdx + 1)
        return modifiedString
    else
        return originalString
    end
end

function stringContains(s, sub)
    return string.find(s:lower(), sub:lower(), 1, true) ~= nil
end

function wildcardMatch(s, p)
    -- Escape all special characters except '*'
    p = p:gsub("[%^%$%(%)%%%.%[%]%+%-%?]", "%%%0")
    -- Replace '*' with '.*' to match any sequence of characters
    p = p:gsub("%*", ".*")
    -- Make the pattern case insensitive
    p = "(?i)" .. p

    -- Find the pattern in the string
    return s:match(p) ~= nil
end
-- Function to recursively search for files matching a query in a directory
local function recursive_search(root_dir, query)
    local file_paths = {}

    -- Function to recursively search directories
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
                if stringContains(file_path, query) then

                    strippedPath = removeFromString(file_path, root_dir)
                    table.insert(file_paths, strippedPath)
                end
            
            end
        end
    end

    -- Start recursive search from the root directory
    search_directory(root_dir)

    return file_paths
end

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
        -- Create a new scratch buffer
        local buf = vim.api.nvim_create_buf(false, true)

        -- Set options for the scratch buffer
        vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile') -- Buffer is not related to a file
        vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe') -- Buffer is removed when hidden
        vim.api.nvim_buf_set_option(buf, 'modifiable', true) -- Buffer is initially modifiable

        -- Create a vertical split and open the scratch buffer
        vim.cmd('vsplit')
        vim.api.nvim_win_set_buf(0, buf)

        return buf
    end

    -- Create the scratch buffer
    local buf = create_scratch_buffer()

    -- Set the buffer mappings and autocommands
    vim.cmd('autocmd BufEnter <buffer> setlocal cursorline')

    -- Function to handle user input and trigger search
    function display_list()
        list = callback(vim.fn.getline(1))
        -- Clear existing lines (except the first line)
        vim.api.nvim_buf_set_lines(buf, 1, -1, false, {})

        -- Append each path to the buffer (make them read-only)
        for _, element in ipairs(list) do
            vim.api.nvim_buf_set_lines(buf, -1, -1, false, {element})
            -- vim.api.nvim_buf_add_highlight(buf, -1, 'Comment', -1, 0, -1)
        end

        -- Disable modification for read-only lines
        vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    end

    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':lua display_list()<CR>', {noremap = true, silent = true})
end



