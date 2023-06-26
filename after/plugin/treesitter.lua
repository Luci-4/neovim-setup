require 'nvim-treesitter.install'.prefer_git = false
require 'nvim-treesitter.install'.compilers = { "clang" }

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)

  ensure_installed = {"help", "python", "javascript", "typescript", "c", "lua", "vim", "rust" },
  highlight = {

    additional_vim_regex_highlighting = false,

  	enable = true,
	custom_captures = {
      ["cplex"] = cplex_highlight,
    },
  }

}
vim.cmd("autocmd BufRead,BufNewFile *.mod set filetype=cplex")
