" vim: foldmethod=marker
" General options {{{1
set nocompatible        " Improved
set foldcolumn=3
set ruler
set number
set autoindent          " always set autoindenting on
set hidden              " Allow to switch to another buffer without writing to file
set autowrite           " Writes on make/shell commands
set autoread            " auto-reload when file changed from the outside
set encoding=utf-8
set nolazyredraw        " Do not redraw uselessly during macro execs
set history=1000
set nowrap              " wrap lines
set title
set scrolloff=3
set laststatus=2        " Always show status line.
set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set pastetoggle=<F2>
set showcmd             " display incomplete commands
set cf                  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set timeoutlen=250      " Time to wait after ESC (default causes an annoying delay)

" Show a unicode end of line symbol at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:↵,trail:~,extends:>,precedes:<
set undodir=~/.vim/tmp  " Persistent undo
set undofile
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" Search {{{2
set ignorecase
set smartcase           " search case sensitive only when one of the letter is uppercase in the search term
set incsearch           " do incremental searching
set hlsearch            " highlight search
set showmatch           " Show matching brackets.

" Indenting {{{2
" see http://vimdoc.sourceforge.net/htmldoc/indent.html#cinoptions-values 
set smarttab
set cindent
set autoindent
set list                " disable line break
set cinoptions=:0,t0   " Affects how cident indents lines.
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set expandtab
set shiftwidth=3        " Tabs under smart indent
set tabstop=3           " Normal tabs

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" VUNDLE CONFIGURATION {{{1
" =================================
filetype off
let vundleInstalled = 0
if !filereadable(expand('~/.vim/bundle/Vundle.vim/README.md'))
   echo "Installing Vundle"
   echo ""
   silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   let vundleInstalled = 1
endif
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " required, let vundle self-manage

source vundles/utils.vim
source vundles/completion.vim
source vundles/git.vim
source vundles/tagging.vim
source vundles/vimextensions.vim
source vundles/dev.vim

Plugin 'altercation/vim-colors-solarized'       " solarized theme

call vundle#end()

" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
if vundleInstalled == 1
   echo "Installing plugins..."
   echo ""
   :PluginInstall
endif

" END OF VUNDLE CONFIGURATION
" ===========================

" Automatically save and reload views {{{1
au BufWritePost,BufLeave,WinLeave ?* mkview
au BufWinEnter ?* silent loadview

"" Set the default font
set guifont=Source\ Code\ Pro\ Medium\ 12

augroup vimconfig
   autocmd!
   " For all text files set 'textwidth' to 100 characters.
   autocmd FileType text setlocal textwidth=100

   " When editing a file, always jump to the last known cursor position.
   " Don't do it when the position is invalid or when inside an event handler
   " (happens when dropping a file on gvim).
   " Also don't do it when the mark is in the first line, that is the default
   " position when opening a file.
   autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

   " Auto source vimsource on changes
   autocmd! bufwritepost .vimrc source $MYVIMRC 
   autocmd! bufwritepost vim.config source $MYVIMRC
augroup END

syntax enable      " enable syntax highlighting

" Key bindings {{{1
let mapleader = ","

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" move between buffers
map <C-right> :bn<cr>
map <C-left> :bp<cr>

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" alt+left, alt+right to navigate splits
nnoremap <A-left> <C-W><C-H>
nnoremap <A-right> <C-W><C-L>

" Move a line of text or visual content using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-down> mz:m+<cr>`z
nmap <M-up> mz:m-2<cr>`z
vmap <M-down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-up> :m'<-2<cr>`>my`<mzgv`yo`z

" no highlight
nmap <leader>h :noh<cr>

" Fold toggle by pressing F9. Create new fold on manual mode too.
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Have space as a fold opener in normal mode
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat 

" Quick docco-husky
nmap <leader>d :!docco-husky %

" PLUGIN: Solarized
" =================
if !has("gui_running")
   set t_Co=256
   set term=xterm-256color
   let g:solarized_termcolors=256
endif
set background=dark
colorscheme solarized

" Source a personnal configuration file if present
if filereadable(expand('~/.vimrcr.perso'))
   source ~/.vimrc.perso
endif

" Source a current directory set of configuration options if present
if filereadable(expand('./.vimrc.local'))
   source ./.vimrc.local
endif
