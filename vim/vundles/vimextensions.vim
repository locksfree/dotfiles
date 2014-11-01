" == VIM EXTENSIONS ==
" ====================

Plugin 'fholgado/minibufexpl.vim'               " Mini buffer explorer
Plugin 'yegappan/mru'                           " Most recent used :MRU
Plugin 'scrooloose/nerdtree'                    " Nerd Tree
Plugin 'bling/vim-airline'                      " light powerline
Plugin 'fisadev/vim-ctrlp-cmdpalette'           " Control palette for vim
Plugin 'tpope/vim-obsession'                    " Automatic session management. :Obsess
Plugin 'xolox/vim-session'                      " :SaveSession is mksession on steroids
Plugin 'mhinz/vim-startify'                     " Start page for vim
Plugin 'vimwiki'                                " Personnal wiki stored in ~/vimwiki
Plugin 'shougo/vinarise.vim'                    " Hex edition
Plugin 'grep.vim'                               " :Grep for vim
if has('python') && has('gui_running')
   Plugin 'mbadran/headlights'                  " List all currently loaded vundles
endif

" PLUGIN: Minibuffer Explorer Settings
" ====================================
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1

" PLUGIN: NERD Tree
" =================
nmap <silent> <leader>t :NERDTreeToggle
imap <silent> <leader><leader> <C-x><C-o>

" PLUGIN: TaskList.vim
" ====================
let g:tlTokenList = ['TODO', 'FIXME', 'REVIEW', 'XXX']

" PLUGIN: CtrlP-CmdPalette
" ========================
map <silent> <leader>l :CtrlPCmdPalette<CR>


