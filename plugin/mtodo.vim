if !exists("g:vim_mtodo_disable_keybindings")
    augroup plugin_mtodo
        autocmd!
        autocmd FileType mtodo nnoremap <silent>gd :normal!mt0g^rx`t<cr>
        autocmd FileType mtodo nnoremap <silent>gu :normal!mt0g^r-`t<cr>
        autocmd FileType mtodo nnoremap <silent>gs :normal!mt0g^r*`t<cr>
    augroup end
endif
