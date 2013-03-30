" Character encoding (if this is not set, all manner of hell breaks loose when
" LC_CYTPE is set to anything unexpected.)
set encoding=utf-8

" Pre-plugin stuff
let g:Powerline_symbols = 'fancy' " Awesome forward-facing arrows for powerline

" let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_switch_buffer = 2
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_clear_cache_on_exit = 1 " retain cache on exit (might mean I have to manually refresh every now and again)
let g:ctrlp_open_new_file = 't' " <c-y> opens file in new tab
let g:ctrlp_arg_map = 0 " for <c-z> and <c-o>
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_root_markers = ['Gemfile', 'README']

" Load vim plugins
"call pathogen#infect($ME_DROPBOX_DOTFILES.'/vim_plugins/')
call pathogen#infect()
call pathogen#helptags()

set wildignore+=doc*,*.png,*.jpg,*.bmp,*.gif,*.jpeg

" enhance command line completion
set wildmenu

" make my leader the comma
let mapleader = ","

" we're running vim, not vi
set nocompatible

" enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" folding stuff
set foldmethod=syntax
set foldcolumn=3
set foldlevelstart=99
set nofoldenable

let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
set t_Co=256

" optimize for fast terminal connections
set ttyfast

" don't add empty newlines at the end of files
set binary
set noeol

set mouse=a
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set autochdir
set showmode
set autoread       " auto-reload modified files (with no local changes)

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
set smartcase " ignore case of searches, unless you use a capital letter
set gdefault " adds the global flag to search/replace by default
set hlsearch " highlight search results

" use mac os clipboard as default paste register
set clipboard=unnamed

" allow cursor beyond last character
set virtualedit=onemore

" history
set history=1000

" syntax stuff
syntax on " highlighting please

" Syntax coloring
set background=dark
"let g:solarized_termcolors = 256
"let g:solarized_termtrans = 1
colorscheme xoria256

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

" make vim save view (state) (folds, cursor, etc) and then load view again.
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:>-,trail:~,extends:>,precedes:<
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
"set listchars=tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad

" Make 'kj' in insert mode bring you back to edit mode
inoremap kj <Esc>

" Fold / unfold current block of code
map <leader>a za

" gundo
map <leader>u :GundoToggle<CR> " Graphical representation of the undo tree

" find with Ack, but in current project
function! AckInProject(command, search)
  execute ":".a:command." ".a:search." --nohtml --nosql ".system("git rev-parse --show-toplevel")
endfunction
command! -nargs=1 Projfind call AckInProject('Ack', '<args>')
command! -nargs=1 ProjfindAppend call AckInProject('AckAdd', '<args>')
map <leader>f :Projfind
map <leader>d :ProjfindAppend

" open new windows
map <leader>sl :vsplit<CR><C-W>l
map <leader>sh :vsplit<CR><C-W>h
map <leader>sj :split<CR><C-W>j
map <leader>sJ :split<CR><C-W>jG
map <leader>sk :split<CR>
map <leader>sK :split<CR>gg
map <leader>t :tabnew<CR>

" move between windows
map gj <C-w>j
map gk <C-w>k
map gl <C-w>l
map gh <C-w>h
map g= <C-w>=
map gr <C-w>r

" move between tabs
nnoremap <C-h> gT
nnoremap <C-l> gt

" move between quickfix errors
nnoremap <C-j> :cp<CR>
nnoremap <C-k> :cn<CR>

" ON-THE-FLY SETTINGS CHANGING
" Edit .vimrc (this file)
map <leader>sv :sp ~/.vimrc<CR><C-W>_
" Edit .zshrc
map <leader>sz :e ~/.zshrc<CR><C-W>_
map <leader>sr :source ~/.vimrc<CR><C-W>_
map <leader>si :set list!<CR> " Show/hide invisibles
map <leader>ss :set hlsearch!<CR> " Toggle search highlighting

" Vimux stuff
map <Leader>c :PromptVimTmuxCommand<CR>
map <Leader>C :RunLastVimTmuxCommand<CR>
map <Leader>rk :InspectVimTmuxRunner<CR>
map <Leader>rq :CloseVimTmuxRunner<CR>
map <Leader>rx :CloseVimTmuxPanes<CR>
vmap <Leader>rr "vy :call RunVimTmuxCommand(@v . "\n", 0)<CR>
nmap <Leader>rr vip<Leader>rr<CR>

" git
map <Leader>gg :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gp :Git pull<CR>
map <Leader>gP :Git push<CR>

" indentation in ruby
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case

" enable filetype detection
filetype on
filetype indent on
filetype plugin on

" commentary filetypes
autocmd FileType ruby set commentstring=#\ %s
autocmd FileType vim set commentstring=\"\ %s

" commenting
map <C-\> \\\

" strip trailing whitespace on save
" autocmd BufWritePre * :%s/\s\+$//e

set pastetoggle=<F2>

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Let's see some useful info in the status line
set statusline=%F\ %m%r%w%y\ %=(%L\ loc)\ [#\%03.3b\ 0x\%02.2B]\ \ %l,%v\ \ %P

" Create an empty line underneath without moving the cursor
noremap <CR> mlo<Esc>`l

" Indent with spacebar
noremap <space> >>