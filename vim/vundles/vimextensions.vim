" == VIM EXTENSIONS ==
" ====================

Plugin 'scrooloose/nerdtree'                    " Nerd Tree
Plugin 'vim-airline/vim-airline'                " light powerline
Plugin 'vim-airline/vim-airline-themes'         " Themes for airline
Plugin 'tpope/vim-obsession'                    " Automatic session management. :Obsess
Plugin 'mhinz/vim-startify'                     " Start page for vim
Plugin 'vimwiki'                                " Personnal wiki stored in ~/vimwiki
Plugin 'shougo/vinarise.vim'                    " Hex edition
Plugin 'shougo/unite.vim'                       " Powerfull plugin to replace others
Plugin 'shougo/neomru.vim'                      " MRU for unite
Plugin 'shougo/vimproc.vim'                     " Grep for unite
Plugin 'shougo/unite-outline'                   " outline for unite
Plugin 'tpope/vim-repeat'                       " Make . support some plugin map
Plugin 'tpope/vim-abolish'                      " Abbrevs & replace short hand
if has('python') && has('gui_running')
   Plugin 'mbadran/headlights'                  " List all currently loaded vundles
endif
Plugin 'powerline/fonts'

" PLUGIN: vim-airline
" ====================
let g:airline#extensions#tabline#enabled = 1

" PLUGIN: mru
" ============
let MRU_Max_Entries = 1000

" PLUGIN: unite.vim
" =================
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
let g:unite_source_history_yank_enable = 1
nnoremap <C-p> :Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <space>m :Unite -no-split -buffer-name=mru -start-insert -quick-match file_mru<cr>
nnoremap <space>o :Unite -buffer-name=outline outline<cr>
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>y :Unite history/yank<cr>
nnoremap <space>b :Unite -quick-match buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" PLUGIN: NERD Tree
" =================
nmap <silent> <leader>t :NERDTreeToggle
imap <silent> <leader><leader> <C-x><C-o>

" PLUGIN: TaskList.vim
" ====================
let g:tlTokenList = ['TODO', 'FIXME', 'REVIEW', 'XXX']
