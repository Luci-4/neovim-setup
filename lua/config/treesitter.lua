require'nvim-treesitter.configs'.setup {
    -- ensure_installed = {"c", "lua", "cpp"}, -- parsers you want to install
    -- sync_install = false,
    -- auto_install = true,
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
    },
}
