-- Load the lspconfig module
local lspconfig = require('lspconfig')

-- -- Function to set up handlers for each language server
-- local function setup_lsp(server, settings)
--     lspconfig[server].setup({
--         cmd = { '/path/to/' .. server, 'argument1', 'argument2' }, -- Specify absolute path here
--         on_attach = function(client, bufnr)
--             -- Set up key mappings, completion, and other client-specific configurations
--             -- This function will be called when the language server is attached to a buffer
--         end,
--         settings = settings
--     })
-- end
lspconfig["pyright"].setup({
    cmd = {'C:\\Users\\wojci\\AppData\\Local\\Programs\\Python\\Python39\\Scripts\\' .. 'pyright.exe'},
    on_attach = function(client, bufnr)
    end,
    settings = {}

})
-- -- Set up language servers
-- setup_lsp('pyright', {})  -- Example for Python
-- setup_lsp('tsserver', {}) -- Example for TypeScript/JavaScript
-- Add setup for other language servers as needed
