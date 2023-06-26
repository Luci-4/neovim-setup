local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
    -- 'pyre',
    -- 'pylsp',
    'html',
    'jsonls',
    'clangd',
    'emmet_ls',
})
-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<M-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<M-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
})

-- cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})
function _gotto_definition_or_implementation()
    vim.lsp.buf.definition()
end
local all_keybinds = {
    -- ['<leader>nd'] = vim.lsp.buf.add_workspace_folder,
    ['cs'] = "vim.lsp.buf.code_action",
    ['co'] = "vim.lsp.buf.completion",
    ['gd'] = "vim.lsp.buf.definition",
    ['='] = "vim.lsp.buf.format",
    ['gh'] = "vim.lsp.buf.hover",
--    ['gi'] = "vim.lsp.buf.implementation",
    ['<leader>lb'] = "vim.lsp.buf.list_workspace_folders",
    ['gr'] = "vim.lsp.buf.references",
    ['cr'] = "vim.lsp.buf.rename",
    ['gs'] = "vim.lsp.buf.signature_help",
    ['<leader>rf'] = "vim.lsp.util.rename",
}
local lsp = require('lsp-zero').preset({
        name = 'minimal',
        set_lsp_keymaps = false,
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
})

lsp.on_attach(function(client, bufnr)
    local noremap = {buffer = bufnr, remap = false}
    local bind = vim.keymap.set


    for keys, cmd in pairs(all_keybinds) do
        -- vim.keymap.set('n', keys, function() cmd() end, {opts})
        bind('n', keys, string.format('<cmd>lua %s()<cr>', cmd), noremap)
    end
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

lsp.ensure_installed('texlab') -- Install the texlab LSP server

-- Configure the texlab LSP server
lsp.configure('texlab', {
    settings = {
        texlab = {
            build = {
                executable = 'latexmk',
                args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                onSave = true
            },
            forwardSearch = {
                executable = 'zathura', -- Replace with your PDF viewer command
                args = { '--synctex-forward', '%l:1:%f', '%p' }
            }
        }
    }
})
