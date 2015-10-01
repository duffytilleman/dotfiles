filetype off
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Tabs and Spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
set expandtab
set autoindent
set smartindent
set smarttab

" Misc
set number
set ruler
set showcmd
set showmatch
set wildmenu
set wildmode=list,full
set nowrap
set hidden
set modeline
set autoread       " auto-reload modified files (with no local changes)
set nocompatible   " don't try to be compatible with vi
set ignorecase     " ignore case in search
set smartcase      " override ignorecase if uppercase is used in search string
set report=0       " report all changes
set laststatus=2   " always show status-line
set cursorline     " highlight current line
set scrolloff=4
"set nofoldenable
set foldmethod=indent
set foldlevel=99
set pastetoggle=<F2>
set colorcolumn=100
set textwidth=100
set formatoptions=cqj  "c: autwrap comments, q: allow 'gq' format, j: strip comment leader on join


" Keep swap files in one of these 
set directory=~/tmp,~/.tmp,/var/tmp,/tmp,.

" Let's see some useful info in the status line
set statusline=%F\ %m%r%w%y\ %=(%L\ loc)\ [#\%03.3b\ 0x\%02.2B]\ \ %l,%v\ \ %P

" Better search
set hlsearch
set incsearch

" File-type
filetype on
filetype plugin on
filetype indent on

" Show trailing white-space
let ruby_space_errors = 1
let python_highlight_space_errors = 1
let c_space_errors = 1
let javascript_space_errors = 1

let c_C99 = 1

if exists("c_no_names")
  unlet c_no_names
endif

" Easy command mode switch
inoremap kj <Esc>
inoremap jk <Esc>

" Fix backspace key in xterm
inoremap  <BS>

" inoremap () ()<Left>
" inoremap [] []<Left>
" inoremap '' ''<Left>
" inoremap "" ""<Left>

inoremap <C-l> <C-x><C-l>

inoremap <C-f> function () {}<Left>

" Enable mouse in insert and normal mode
set mouse=vin

" Create an empty line underneath without moving the cursor
" noremap <CR> mlo<Esc>`l
noremap <expr> <CR> (&buftype is# "quickfix" ? "<CR>" : "mlo<Esc>`l")

" Indent with spacebar
noremap <space> >>
noremap <S-Tab> <<

" Move easily between ^ and $
noremap <C-h> ^
noremap <C-l> $
noremap j gj
noremap k gk

" Syntax coloring
set t_Co=256
colorscheme xoria256
syntax enable

" Minimum window height = 0
set wmh=0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
endfunction

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
      return CleverTab()
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" inoremap <Tab> <C-R>=CleverTab()<CR>

"
" Tabline
"
if exists("+showtabline")
  function! MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1

    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let file = bufname(buflist[winnr - 1])
      let file = fnamemodify(file, ':p:t')
      let file = (file == '') ? '[No Name]' : file
      let s .= ' ' . file . ' '
      let s .= winnr
      let s .= (getbufvar(buflist[winnr - 1], '&modified') ? '+ ' : ' ')
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=2
  set tabline=%!MyTabLine()
endif
      
" V buffer split
" Vertical Split Buffer Function
function! VerticalSplitBuffer(buffer)
    execute "vert belowright sb" a:buffer 
endfunction
" Vertical Split Buffer Mapping
command! -nargs=1 Vbuffer call VerticalSplitBuffer(<f-args>)

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
let mapleader=","
let maplocalleader="\\"

noremap gh <C-W>h
noremap gj <C-W>j
noremap gk <C-W>k
noremap gl <C-W>l
noremap g= <C-W>=
noremap g\| <C-W>\|
noremap g< <C-W><
noremap g> <C-W>>

" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$

" :W to save file, making directories as needed
function! WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
    redraw!
endfunction
command! W call WriteCreatingDirs()

" remap omnicomplete
inoremap <leader>, <C-x><C-o>

" Open quickfix window automatically after :grep and :Ggrep
autocmd QuickFixCmdPost *grep* cwindow

nnoremap <leader>g :silent Ggrep<space>

" type ,t in normal mode to close open html tags
au FileType html inoremap <buffer> <leader>t </<C-x><C-o>

" swap words with ,s on first word then ,t on second word
noremap <leader>s "sdiwms
noremap <leader>t "tdiw"sp`s"tP

" Essentially the oposite of 'J' (join)
noremap <c-J> i<cr><esc>l

" <c-u> in normal mode capitalizes current word
inoremap <c-u> <esc>muviwU`ua

" quickly edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:echo "Sourced .vimrc"<cr>

vnoremap <c-q> <esc>`<i'<esc>`>a'<esc>

au FileType python iabbrev <buffer> ii import ipdb; ipdb.set_trace()

let syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['pyflakes', 'flake8']
let g:syntastic_aggregate_errors = 1

let g:ctrlp_user_command = ['.git', 'cd %s && cat <(git ls-files) <(git ls-files --others --exclude-standard)']
" let g:ctrlp_user_command = ['.git', 'cd %s && cat git ls-files git ls-files --others --exclude-standard']
let g:ctrlp_match_window = 'max:20,results:100'

set undofile
set undodir=~/.vim/undo/

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

noremap <F3> :redraw!<cr>

au FileType gitcommit set tw=72 colorcolumn=72

highlight ExtraWhitespace ctermbg=235 guibg=110
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


"JsBeautify Settings
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType html noremap <buffer>  <c-f> :call HtmlBeautify()<cr>
autocmd FileType html vnoremap <buffer>  <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css noremap <buffer>  <c-f> :call CssBeautify()<cr>
autocmd FileType css vnoremap <buffer>  <c-f> :call RangeCssBeautify()<cr>

"vim-multiple-cursors settings
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0
