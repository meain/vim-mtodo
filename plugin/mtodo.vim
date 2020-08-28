function s:MoveCompletedToBottom() abort
    let l:current_line = getline(line('.'))
    let l:line_number = line('.')
    let l:total_lines = line('$')
    let pos = l:line_number

    if l:current_line !~# '^\ *x'
        echo "Not a done item, cannot move."
        return
    endif

    let spaces = '^'
    for char in split(l:current_line, '\zs')
        if char ==# ' '
            let spaces = spaces.' '
        else
            break
        endif
    endfor

    " 1: check down till number of space changes
    while pos < l:total_lines
        let line = getline(pos)
        if line !~# spaces
            let pos = pos - 1
            break
        endif
        let pos = pos+1
    endwhile
    echo pos

    " 2: check up till startswith x fails
    while pos > l:line_number
        let line = getline(pos)
        if line !~# spaces.'[ x]'
            break
        endif
        let pos = pos-1
    endwhile

    " Move the exact line
    execute l:line_number 'delete _'
    let failed = append(pos-1, l:current_line)

    " Need to move sub items as well
    let line = getline(l:line_number)
    while line =~# spaces.' '
        let line = substitute(line, '^\( *\).', '\1x', '')
        execute l:line_number 'delete _'
        let failed = append(pos-1, line)
        let line = getline(l:line_number)
    endwhile

    execute 'normal!k'
endfunction
command -bang MTODOMoveCompletedToBottom call <sid>MoveCompletedToBottom()

if !exists("g:vim_mtodo_disable_keybindings")
    augroup plugin_mtodo
        autocmd!
        autocmd FileType mtodo nnoremap <silent>gd :normal!mt0g^rx`t<cr>:MTODOMoveCompletedToBottom<cr>
        autocmd FileType mtodo nnoremap <silent>gu :normal!mt0g^r-`t<cr>
        autocmd FileType mtodo nnoremap <silent>gs :normal!mt0g^r*`t<cr>
    augroup end
endif
