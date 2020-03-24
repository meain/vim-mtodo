augroup _mtodo
    autocmd!
    autocmd FileType mtodo nnoremap gd :normal!mt0g^rx`t<cr>
    autocmd FileType mtodo nnoremap gu :normal!mt0g^r-`t<cr>
augroup end
