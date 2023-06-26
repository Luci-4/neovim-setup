vim.cmd([[
  augroup MySession
    autocmd!
    autocmd BufWritePre * mksession! ~/mysession.vim
  augroup END
]])

vim.cmd([[
  augroup remove_trailing_whitespace
    autocmd!
    autocmd BufWritePre *.py %s/\s\+$//e
  augroup END
]])
