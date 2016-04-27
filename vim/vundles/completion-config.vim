set omnifunc=syntaxcomplete#Complete

" PLUGIN: SuperTab
" ================
let g:SuperTabDefaultCompletionType = "context"

" Remap code completion to Ctrl+Space 
inoremap <Nul> <C-x><C-o> 
inoremap <expr> <Nul> ((pumvisible())?("\<C-n>"):("\<C-x><c-i>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-x><c-o>"))


