" == DEVELOPMENT RELATED PLUGINS ==
" =================================

Plugin 'DirDiff.vim'                            " Recursive directory diffing
Plugin 'chrisbra/Recover.vim'                   " Show a diff on recovered buffers
Plugin 'scrooloose/nerdcommenter'               " Nerd commenter
Plugin 'scrooloose/syntastic'                   " Syntax highlighting
Plugin 'TaskList.vim'                           " Todo list based on code comments: FIXME, TODO, XXX, etc.
Plugin 'vim-scripts/argtextobj.vim'             " Text-objects for argumentis
Plugin 'michaeljsmith/vim-indent-object'        " Text-objects for lines at same level of indent
Plugin 'tpope/vim-surround'                     " Operate on surroundings
Plugin 'FooSoft/vim-argwrap'                    " Argument wrapping/un-wrapping
Plugin 's3rvac/AutoFenc'                        " auto-detects file encodings
Plugin 'SirVer/ultisnips'                       " snippet manager
Plugin 'Raimondi/delimitMate'                   " Autocompletion for brackets, parens, etc.
Plugin 'Valloric/YouCompleteMe'                 " Autocompletion for everything else

" GIT
Plugin 'gregsexton/gitv'                        " Gitk for vim. Extension to fugitive
Plugin 'tpope/vim-fugitive'                     " Git integration
Plugin 'syngan/vim-gitlab'                      " ViM support for gitlab
Plugin 'airblade/vim-gitgutter'                 " Shows line status in a gutter when checked against index

" Programming language specific bundles
Plugin 'elzr/vim-json'                          " Strict JSON highlighting
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
Plugin 'racer-rust/vim-racer'                   " RUST syntax highlighting
Plugin 'dleonard0/pony-vim-syntax'              " Pony syntax

"Delete trailing white space
fun! <SID>DeleteTrailingWS()
  exe "normal mz"
  let l = line(".")
  let c = col(".")
  %s/\s\+$//ge
  call cursor(l, c)
  exe "normal `z"
endfunc
autocmd BufWrite * :call <SID>DeleteTrailingWS()

" JS & Coffee script settings
augroup devgrp
   autocmd!

   au BufNewFile,BufReadPost *.js setl shiftwidth=3 tabstop=3 expandtab
   " Coffee-script: Recompile on save and show errors
   au BufNewFile,BufReadPost *.js setl shiftwidth=3 expandtab

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

" Pony
augroup devgrp
   autocmd!

   autocmd Filetype pony au BufNewFile,BufReadPost setl shiftwidth=3 tabstop=3 expandtab
   autocmd FileType pony autocmd BufNewFile,BufReadPost setl foldmethod=syntax nofoldenable
   au FileType pony setl nocindent
augroup END

augroup devgrp
   autocmd!

   au BufNewFile,BufReadPost *.js setl shiftwidth=3 tabstop=3 expandtab

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

" PLUGIN: syntastic
" =================
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_compiler_options = '-std=c++0x'

" PLUGIN: vim-javascript
" ======================
let g:javascript_conceal = 1 " Replace function by f, etc

iabbrev fixme // FIXME:

" PLUGIN: racer
" =============
let g:racer_cmd="racer"
let $RUST_SRC_PATH="~/dev/rust/src/"

" PLUGIN: vim-argwrap
" ==============
nnoremap <silent> <leader>a :ArgWrap<CR>

" PLUGIN: ulti-snip
" =================
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=['UltiSnips']
set runtimepath+=.tools

" PLUGIN: YCM
let g:ycm_key_list_select_completion = ['<C-J>']
let g:ycm_key_list_select_completion = ['<C-K>']

