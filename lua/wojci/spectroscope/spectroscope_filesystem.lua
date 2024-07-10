require("wojci.spectroscope.utils.filesystem")

function search_for_files(query)
    local root_dir = vim.fn.getcwd()
    root_dir = root_dir:gsub("\\", "/")
    local result_paths = filesystem_recursive_search(root_dir, query)
    return result_paths
end



