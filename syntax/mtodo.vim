syntax match TODOTitle /^#.*/
syntax match TODOPending /^\s*- .*/
syntax match TODODone /^\s*x .*/
syntax match TODOImportant /^\s*\* .*/

highlight default link TODOTitle Title
highlight default link TODOPending Normal
highlight default link TODODone Comment
highlight default link TODOImportant Directory
