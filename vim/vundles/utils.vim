" == PLUGINS REQUIRED BY OTHER PLUGINS ==
" =======================================

Plugin 'xolox/vim-misc'                         " Misc plugins for xolox
Plugin 'vim-scripts/netrw.vim'                  " network read/write
Plugin 'vim-scripts/ReplaceWithRegister'        " replace content with register "xgr to replace selection with current "x
Plugin 'christoomey/vim-sort-motion'            " Sort motions
Plugin 'godlygeek/tabular'                      " Tabularize

" PLUGIN: Tabularize
" ==================
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

