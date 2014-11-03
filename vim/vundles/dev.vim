" == DEVELOPMENT RELATED PLUGINS ==
" =================================

Plugin 'DirDiff.vim'                            " Recursive directory diffing
Plugin 'chrisbra/Recover.vim'                   " Show a diff on recovered buffers
Plugin 'DoxygenToolkit.vim'                     " Doxygen
Plugin 'scrooloose/nerdcommenter'               " Nerd commenter
Plugin 'scrooloose/syntastic'                   " Syntax highlighting
Plugin 'godlygeek/tabular'                      " Tabularize
Plugin 'TaskList.vim'                           " Todo list based on code comments: FIXME, TODO, XXX, etc.

" Programming language specific bundles
Plugin 'elzr/vim-json'                          " Strict JSON highlighting
Plugin 'mattn/emmet-vim'                        " ZenCoding for vim <C-Y>,
Plugin 'vim-scripts/Better-CSS-Syntax-for-Vim'  " CSS Coloration etc.
Plugin 'mklabs/grunt.vim'                       " Support for Grunt from vim
Plugin 'LaTeX-Box-Team/LaTeX-Box'               " Latex toolbox
Plugin 'wting/rust.vim'                         " Rust
Plugin 'kchmck/vim-coffee-script'               " Coffee script support
Plugin 'skammer/vim-css-color'                  " Color highlighting, rgb and rgba notations
Plugin 'groenewege/vim-less'                    " Support for LESS
Plugin 'pangloss/vim-javascript'                " Javascript plugin
Plugin 'plasticboy/vim-markdown'                " Markdown support
Plugin 'mustache/vim-mustache-handlebars'       " Support for Handlebars
Plugin 'wavded/vim-stylus'                      " Syntax highlighting for stylus
Plugin 'cespare/vim-toml'                       " Syntax highlighting for Toml configuration file format

"Delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" JS & Coffee script settings
augroup devgrp
   autocmd!

   au BufNewFile,BufReadPost *.js setl shiftwidth=3 tabstop=3 expandtab
   " Coffee-script: Recompile on save and show errors
   au BufNewFile,BufReadPost *.js setl shiftwidth=3 expandtab

   autocmd BufWrite *.py :call DeleteTrailingWS()
   autocmd BufWrite *.js :call DeleteTrailingWS()

   " PLUGIN: vim-coffee-script
   " =========================
   autocmd QuickFixCmdPost * nested cwindow | redraw!
   autocmd BufWritePost *.coffee silent make!
   autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
   autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

   au FileType cpp,hpp setl foldmethod=syntax foldcolumn=3 

   " Javascript
   au FileType javascript call JavaScriptFold()
   au FileType javascript setl fen
   au FileType javascript setl nocindent
augroup END

" On ,m, save all and run spec folder with jasmine
map <leader>m :wa \|! jasmine-node spec --coffee --noColor <CR>

" Run vow with ,tw or ,ta
map <leader>tw :w!<cr>:!vows<cr>
map <leader>ta :w!<cr>:!vows --spec<cr>

function! JavaScriptFold()
   setl foldmethod=syntax
   setl foldlevelstart=1
   syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

   function! FoldText()
      return substitute(getline(v:foldstart), '{.*', '{...}', '')
   endfunction
   setl foldtext=FoldText()
endfunction

" PLUGIN: emmet
" =============
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" PLUGIN: syntastic
" =================
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_compiler_options = '-std=c++0x'

" PLUGIN: Tabularize
" ==================
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" PLUGIN: vim-javascript
" ======================
let g:javascript_conceal = 1 " Replace function by f, etc

iabbrev fixme // FIXME: 
