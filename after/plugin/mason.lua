require("mason").setup()
require("mason-lspconfig").setup({
    ensure_instaled = {"clangd", "pyright", "lua-language-server"},
})


require("mason-lspconfig").setup_handlers {
    pyright = function ()
        lspconfig.pyright.setup {
            settings = { python = { analysis = { autoImportCompletions = false } }}
        }
    end,
    clangd = function ()
       lspconfig.clangd.setup {
            cmd = {"clangd", "--clang-tidy", "--background-index", "--header-insertion=never"}
       }
    end,
    function (server_name)
        lspconfig[server_name].setup {}
    end,
}
