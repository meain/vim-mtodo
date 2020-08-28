function s:MoveCompletedToBottom() abort
    let l:current_line = getline(line('.'))
    let l:line_number = line('.')
    let l:total_lines = line('$')
    let pos = l:line_number

    " 1: check down till number of space changes
    let start_pattern = ''  " Check for indent(count of spaces)
    while pos < l:total_lines
        let line = getline(pos)
        if line !~# start_pattern
            break
        endif
        let pos = pos+1
    endwhile

    " 2: check up till startswith x fails
    let start_pattern = 'x'  " Check for start of done
    while pos > l:line_number
        let line = getline(pos)
        if line !~# start_pattern
            break
        endif
        let pos = pos-1
    endwhile

    execute l:line_number 'delete _'
    let failed = append(pos-1, l:current_line)
endfunction
command -bang MTODOMoveCompletedToBottom call <sid>MoveCompletedToBottom()

if !exists("g:vim_mtodo_disable_keybindings")
    augroup plugin_mtodo
        autocmd!
        autocmd FileType mtodo nnoremap <silent>gd :normal!mt0g^rx`t<cr>
        autocmd FileType mtodo nnoremap <silent>gu :normal!mt0g^r-`t<cr>
        autocmd FileType mtodo nnoremap <silent>gs :normal!mt0g^r*`t<cr>
    augroup end
endif
