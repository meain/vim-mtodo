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
    endif

    execute 'normal!k'
endfunction
command -bang MTODOMoveCompletedToBottom call <sid>MoveCompletedToBottom()

function s:ChangeMark(mark) abort
    let l:current_line = getline(line('.'))
    if l:current_line =~# '^\ *#'
        echo "Cannot change headings"
        return
    endif
    execute 'normal!mt0g^r'.a:mark.'`t'
    if exists("g:vim_mtodo_move_done_to_bottom") && g:vim_mtodo_move_done_to_bottom && a:mark ==# 'x'
        call s:MoveCompletedToBottom()
    endif
endfunction
command -bang MTODOMarkAsDone call <sid>ChangeMark('x')
command -bang MTODOMarkAsUndone call <sid>ChangeMark('-')
command -bang MTODOMarkAsStarred call <sid>ChangeMark('*')

if !exists("g:vim_mtodo_disable_keybindings") || g:vim_mtodo_disable_keybindings == 0
    augroup plugin_mtodo
        autocmd!
        autocmd FileType mtodo nnoremap <silent>gd :MTODOMarkAsDone<cr>
        autocmd FileType mtodo nnoremap <silent>gu :MTODOMarkAsUndone<cr>
        autocmd FileType mtodo nnoremap <silent>gs :MTODOMarkAsStarred<cr>
    augroup end
endif
