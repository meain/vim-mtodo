syntax match MTODOTitle /^#.*/
syntax match MTODOPending /^\s*- .*/
syntax match MTODODone /^\s*x .*/
syntax match MTODOImportant /^\s*\* .*/

highlight default link MTODOTitle Title
highlight default link MTODOPending Normal
highlight default link MTODODone Comment
highlight default link MTODOImportant Directory
