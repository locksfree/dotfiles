" vim: foldmethod=marker
" General options {{{1
set nocompatible        " Improved
set foldcolumn=3
set noruler
set number              " Show line numbers
set relativenumber      " Use relative numbering
set autoindent          " always set autoindenting on
set hidden              " Allow to switch to another buffer without writing to file
set autowrite           " Writes on make/shell commands
set autoread            " auto-reload when file changed from the outside
set encoding=utf-8      " default encoding
set nolazyredraw        " Do not redraw uselessly during macro execs
set magic               " extended regular expressions
set nostartofline       " keep cursor in place with page movements
set history=1000
set nowrap              " wrap lines
set title
set scrolloff=3
set laststatus=2        " Always show status line.
set spell               " Turn on spell checking
set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set pastetoggle=<F2>
set showcmd             " display incomplete commands
set cf                  " Enable error files & error jumping.
set clipboard+=unnamedplus " Yanks go on the clipboard
set timeoutlen=25       " Time to wait after ESC (default causes an annoying delay)
set nojoinspaces        " use single space to join lines, collapsing other spaces into one
set shortmess+=aIoOtT   " abbreviations of message (no hit enter... message)
set secure
set nomodeline

" Insert the contents of the clipboard.
nnoremap <silent> <Leader>P :set paste<CR>"+]P:set nopaste<CR>
nnoremap <silent> <Leader>p :set paste<CR>"+]p:set nopaste<CR>
vnoremap          <Leader>p "+p

" Show a unicode end of line symbol at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:↵,trail:~,extends:>,precedes:<
set undodir=~/.vim/tmp  " Persistent undo
set undolevels=1000
set ttyfast             " Improve redrawing
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
set autoindent
set copyindent          " copy indent from previous line
set nosmartindent
set nocindent
set list                " disable line break
set expandtab
set shiftwidth=3        " Tabs under smart indent
set tabstop=3           " Normal tabs
set fo+=q               " allow formatting of commetns with gq
set fo-=r fo-=o         " turn off automatic insertion of comment characters

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Key bindings {{{1
let mapleader = ","

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

if !exists("*DotSource")
   function DotSource(name)
     exec 'source'.resolve(resolve(expand('$MYVIMRC'))[:-10].'/vundles/'.a:name.'.vim')
   endfunction
endif

" I have split the configuration in different files for ease of maitenance
call DotSource('utils')
call DotSource('tagging')
call DotSource('vimextensions')
call DotSource('dev')

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

" Autocommands {{{1
augroup vimconfig
   autocmd!

   " Automatically save and reload views
   au BufWritePost,BufLeave,WinLeave ?* mkview
   au BufWinEnter ?* silent loadview

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
   autocmd! bufwritepost *.vim source $MYVIMRC
augroup END

syntax enable      " enable syntax highlighting

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

" http://jeetworks.org/vim-making-those-arrow-keys-work-for-you-or-why-the-anti-arrow-key-propoganda-is-wrong/
" Disable arrow keys
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
noremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

function! DelEmptyLineAbove()
    if line(".") == 1
        return
    endif
    let l:line = getline(line(".") - 1)
    if l:line =~ '^s*$'
        let l:colsave = col(".")
        .-1d
        silent normal! <C-y>
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineAbove()
    let l:scrolloffsave = &scrolloff
    " Avoid jerky scrolling with ^E at top of window
    set scrolloff=0
    call append(line(".") - 1, "")
    if winline() != winheight(0)
        silent normal! <C-e>
    endif
    let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
    if line(".") == line("$")
        return
    endif
    let l:line = getline(line(".") + 1)
    if l:line =~ '^s*$'
        let l:colsave = col(".")
        .+1d
        ''
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineBelow()
    call append(line("."), "")
endfunction

" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent
" I modified this to only keep indenting and I set the up/down to moving lines up and down instead
function! SetArrowKeysAsTextShifters()
    " normal mode
    nmap <silent> <Left> <<
    nmap <silent> <Right> >>

    " visual mode
    vmap <silent> <Left> <
    vmap <silent> <Right> >

    " insert mode
    imap <silent> <Left> <C-D>
    imap <silent> <Right> <C-T>
    inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a
    inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a

    " disable modified versions we are not using
    nnoremap  <S-Up>     <NOP>
    nnoremap  <S-Down>   <NOP>
    nnoremap  <S-Left>   <NOP>
    nnoremap  <S-Right>  <NOP>
    vnoremap  <S-Up>     <NOP>
    vnoremap  <S-Down>   <NOP>
    vnoremap  <S-Left>   <NOP>
    vnoremap  <S-Right>  <NOP>
    inoremap  <S-Up>     <NOP>
    inoremap  <S-Down>   <NOP>
    inoremap  <S-Left>   <NOP>
    inoremap  <S-Right>  <NOP>
endfunction

call SetArrowKeysAsTextShifters()

" Move a line of text or visual content using ALT+[jk] or Comamnd+[jk] on mac
nnoremap <silent> <DOWN> <ESC>mz:m+<cr>`z
nnoremap <silent> <UP>   <ESC>mz:m-2<cr>`z
vmap <silent> <down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <silent> <up> :m'<-2<cr>`>my`<mzgv`yo`z

" Fold toggle by pressing F9. Create new fold on manual mode too.
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Have space as a fold opener in normal mode
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

inoremap <C-s> <esc>:w<CR>
nnoremap <silent> <C-s> <ESC>:w<CR>

let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat

" Move by virtual lines even with wrapping enabled
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Make Y yank everything from the cursor to the end of the line. This makes Y
" act more like C or D because by default, Y yanks the current line (i.e. the
" same as yy).
noremap Y y$

" Allows you to easily replace the current word and all its occurrences.
nnoremap <Leader>rc :%s/\<<C-r><C-w>\>/
vnoremap <Leader>rc y:%s/<C-r>"/

" Allows you to easily change the current word and all occurrences to something
" else. The difference between this and the previous mapping is that the mapping
" below pre-fills the current word for you to change.
nnoremap <Leader>cc :%s/\<<C-r><C-w>\>/<C-r><C-w>
vnoremap <Leader>cc y:%s/<C-r>"/<C-r>"

" Remove ANSI color escape codes for the edited file. This is handy when
" piping colored text into Vim.
nnoremap <Leader>rac :%s/<C-v><Esc>\[\(\d\{1,2}\(;\d\{1,2}\)\{0,2\}\)\?[m\|K]//g<CR>

" PLUGIN: Solarized
" =================
if !has("gui_running")
   set t_Co=256
   set term=xterm-256color
   let g:solarized_termcolors=256
   if &term =~ '256color'
      " Disable background color erase
      set t_ut=
   endif
endif
set background=dark
colorscheme solarized

" Source personnal and local files {{{1

" Source a personnal configuration file if present
if filereadable(expand('~/.vimrc.perso'))
      source ~/.vimrc.perso
endif

" Source a current directory set of configuration options if present
if filereadable(expand('./.vimrc.local'))
   source ./.vimrc.local
endif

set foldmethod=manual
"" Set the default font
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
     let g:airline_symbols = {}
  endif
let g:airline_symbols.space = "\ua0"
"set guifont=Sauce\ Code\ Powerline\ Medium\ 10
let g:airline_theme='solarized'
