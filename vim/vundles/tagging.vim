" == TAGGING ==
" =============

Plugin 'a.vim'                                  " Quick switch from .c -> .h etc. :A
Plugin 'xolox/vim-easytags'                     " Tagging on steroid

" PLUGIN: easytags
" ================

let g:easytags_async = 1
let g:easytags_file = '~/.vim/tags'
"let g:easytags_autorecurse = 0
let g:easytags_include_members = 1
"let g:easytags_on_cursorhold = 0
highlight link cMember Special
highlight cMember gui=italic
let g:easytags_suppress_ctags_warning = 0
let g:easytags_suppress_report = 0
let g:easytags_updatetime_min = 30000

