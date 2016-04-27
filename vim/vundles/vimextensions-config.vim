" PLUGIN: Minibuffer Explorer Settings
" ====================================
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1

" PLUGIN: NERD Tree
" =================
nnoremap <silent> <leader>t :NERDTreeToggle
imap <silent> <leader><leader> <C-x><C-o>

" PLUGIN: TaskList.vim
" ====================
let g:tlTokenList = ['TODO', 'FIXME', 'REVIEW', 'XXX']

" PLUGIN: CtrlP-CmdPalette
" ========================
map <silent> <leader>l :CtrlPCmdPalette<CR>


