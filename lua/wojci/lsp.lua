-- Load the lspconfig module
-- local lspconfig = require('lspconfig')

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
-- lspconfig["pyright"].setup({
    -- cmd = {'C:\\Users\\wojci\\AppData\\Local\\Programs\\Python\\Python39\\Scripts\\' .. 'pyright.exe'},
    -- on_attach = function(client, bufnr)
    -- end,
    -- settings = {}

-- })
-- vim.lsp.start({ name = 'pyright', cmd = {'pyright'}, root_dir = 'C:/Users/wojci/Desktop/Uni/sem6/ick/analysis'})
local api = vim.api
local lsp = vim.lsp

function start_pyright()
    local root_dir = vim.fn.getcwd()
    local client = lsp.start_client({
        cmd = { 'pyright-langserver', '--stdio' },
        root_dir = root_dir,
        init_options = {
            diagnosticMode = 'workspace',
            completeFunctionParens = true,
        },
        flags = {
            debounce_text_changes = 150,
        }
    })
    lsp.buf_attach_client(0, client)
end

function start_clangd()
    if next(vim.lsp.get_active_clients({ bufnr = 0 })) == nil then
        print("clangd started")
        local root_dir = vim.fn.getcwd()
        local client = lsp.start_client({
            cmd = { 'clangd', '--background-index' },
            root_dir = root_dir,
            init_options = {
                clangdFileStatus = true,
            },
            flags = {
                debounce_text_changes = 150,
            }
        })
        lsp.buf_attach_client(0, client)
    else
        print("clangd already attached")
    end
end

function start_pylsp()
    print("pylsp started")
    local root_dir = vim.fn.getcwd()
    local client = lsp.start_client({
        cmd = { 'pylsp' },
        root_dir = root_dir,
        init_options = {},
        flags = {
            debounce_text_changes = 150,
        }
    })
    lsp.buf_attach_client(0, client)
end

api.nvim_command([[augroup lsp]])
api.nvim_command([[  au!]])
api.nvim_command([[  au FileType python lua start_pylsp()]])
api.nvim_command([[  au FileType cpp lua start_clangd()]])
api.nvim_command([[augroup END]])
-- api.nvim_set_keymap('n', 'gd', '<Cmd>lua =vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

-- Configure pyright (for Python)
-- lspconfig.pyright.setup{}
-- local lspconfig = require('lspconfig')

-- lspconfig.pyright.setup{}

-- local on_attach = function(_, bufnr)
    -- local buf_set_keymap = vim.api.nvim_buf_set_keymap
    -- local buf_set_option = vim.api.nvim_buf_set_option
    -- local opts = { noremap=true, silent=true }

    -- Enable completion triggered by <c-x><c-o>
    -- buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- end
-- local servers = { 'pyright' }  -- Add more servers as needed
-- for _, lsp in ipairs(servers) do
    -- lspconfig[lsp].setup {
        -- on_attach = on_attach,
    -- }
-- end
-- require'lspconfig'.pyright.setup{
    -- cmd = {'C:\\Users\\wojci\\AppData\\Local\\Programs\\Python\\Python39\\Scripts\\' .. 'pyright.exe'},
-- }
-- -- Set up language servers
-- setup_lsp('pyright', {})  -- Example for Python
-- setup_lsp('tsserver', {}) -- Example for TypeScript/JavaScript
-- Add setup for other language servers as needed
