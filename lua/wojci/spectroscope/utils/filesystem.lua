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

function filesystem_preload_cache(root_dir)
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

function filesystem_recursive_search(root_dir, query)
    local query_lower = query:lower()

    if not search_cache[root_dir] then
        filesystem_preload_cache(root_dir)
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
