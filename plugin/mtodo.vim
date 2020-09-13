command -bang MTODOMarkAsDone call mtodo#ChangeMark('x')
command -bang MTODOMarkAsUndone call mtodo#ChangeMark('-')
command -bang MTODOMarkAsStarred call mtodo#ChangeMark('*')
command -bang MTODOMoveCompletedToBottom call mtodo#MoveCompletedToBottom()
command -bang MTODOReorderAllTodo call mtodo#ReorderAllTodo()

if !exists("g:vim_mtodo_disable_keybindings") || g:vim_mtodo_disable_keybindings == 0
    augroup plugin_mtodo
        autocmd!
        autocmd FileType mtodo nnoremap <silent>gd :MTODOMarkAsDone<cr>
        autocmd FileType mtodo nnoremap <silent>gu :MTODOMarkAsUndone<cr>
        autocmd FileType mtodo nnoremap <silent>gs :MTODOMarkAsStarred<cr>
    augroup end
endif
