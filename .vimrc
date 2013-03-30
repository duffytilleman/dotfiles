execute pathogen#infect()
filetype plugin indent on
syntax on
colorscheme xoria256
imap kj <ESC>
set encoding=utf-8
set mouse=a

set mouse=a
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set autochdir
set showmode

" show the cursor position
set ruler

" show the (partial) command as it's being typed
set showcmd

" line numbers
set number

" start scrolling three lines before the horizontal window border
set scrolloff=3

" always show the status line
set laststatus=2

" make backspace delete over line brakes, auto indentation, and the place where insert mode began
set backspace=2

set switchbuf+=usetab

" Don't reset cursor to the start of the line when moving around
set nostartofline

" search stuff
set incsearch " highlight dynamically as pattern is typed
set ignorecase " ignore case of searches
set gdefault " adds the global flag to search/replace by default
set hlsearch " highlight search results

" use mac os clipboard as default paste register
" set clipboard=unnamed

" allow cursor beyond last character
set virtualedit=onemore

" history
set history=1000

" syntax stuff
syntax on " highlighting please

" Highlight current line
set cursorline
hi cursorline guibg=#333333
hi CursorColumn guibg=#333333

" don't show the intro message when starting vim
set shortmess=atI

" show the filename in the window titlebar
set title

" respect modeline in files
set modeline
set modelines=4

" disable error bells
set noerrorbells
set visualbell

" Resizing of windows
map + <C-w>+
map _ <C-w>-
map ) <C-w>>
map ( <C-w><
set equalalways

" Create directories if they don't exist
silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'

" Directories for backups
set backup
set backupdir=$HOME/.vimbackup//
set directory=$HOME/.vimswap//
set viewdir=$HOME/.vimviews//
if exists("&undodir")
  set undodir=$HOME/.vimundo//
endif


