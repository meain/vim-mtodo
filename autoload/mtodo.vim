function! mtodo#MoveCompletedToBottom(...) abort
    if a:0 ==# 1
        let l:line_number = a:1
    else
        let l:line_number = line('.')
    endif
    let l:current_line = getline(l:line_number)
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
        if line !~# spaces || line =~# '#' || len(line) ==# 0
            let pos = pos - 1
            break
        endif
        let pos = pos+1
    endwhile

    " 2: check up till startswith x fails
    while pos > l:line_number
        let line = getline(pos)
        if line !~# spaces.' *x'
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

    " Mark todo items as done without move
    if pos == l:line_number
        let ln = pos+1
        let line = getline(ln)
        while line =~# spaces.' '
            let line = getline(ln)
            let changed_line = substitute(line, '^\( *\).', '\1x', '')
            call setline(ln, changed_line)
            let ln = ln+1
            let line = getline(ln)
        endwhile
        execute 'normal!k'
    endif
endfunction

function! mtodo#ChangeMark(mark) abort
    let l:current_line = getline(line('.'))
    if l:current_line =~# '^\ *#'
        echo "Cannot change headings"
        return
    endif
    execute 'normal!mt0g^r'.a:mark.'`t'
    if exists("g:vim_mtodo_move_done_to_bottom") && g:vim_mtodo_move_done_to_bottom && a:mark ==# 'x'
        call mtodo#MoveCompletedToBottom()
    endif
endfunction

function! mtodo#ReorderAllTodo() abort
    let l:total_lines = line('$')
    let l:current_line = 0
    while l:current_line < l:total_lines
        let l:current_line_conent = getline(l:current_line)
        if l:current_line_conent =~# '^\ *x'
            call mtodo#MoveCompletedToBottom(l:current_line)
            if l:current_line_conent ==# getline(l:current_line)
                let l:current_line = l:current_line + 1
            endif
        else
            let l:current_line = l:current_line + 1
        endif
    endwhile
endfunction
