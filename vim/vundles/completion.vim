" == COMPLETION ==
" ================

Plugin 'Raimondi/delimitMate'                   " Autocompletion for brackets, parens, etc.
Plugin 'ervandew/snipmate.vim'                  " Snippet manager
Plugin 'ervandew/supertab'                      " Supertab - autocompletion

set omnifunc=syntaxcomplete#Complete

" PLUGIN: SuperTab
" ================
let g:SuperTabDefaultCompletionType = "context"

" Remap code completion to Ctrl+Space 
inoremap <Nul> <C-x><C-o> 
inoremap <expr> <Nul> ((pumvisible())?("\<C-n>"):("\<C-x><c-i>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-x><c-o>"))


