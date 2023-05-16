filetype off

call plug#begin()
Plug 'AndrewRadev/splitjoin.vim' "Easy move from single/multiine statements
" Plug 'SirVer/ultisnips'         "snippet manager
Plug 'airblade/vim-gitgutter'   "gutter markers for changed lines
Plug 'alvan/vim-closetag'       "autoclose html tags
Plug 'cosminadrianpopescu/vim-tail' "tail-f in vim with TailStart and TailStop
" Plug 'duffytilleman/vim-polyglot' "all the language packs. my fork is from 2017 and has one fix for groovy (used by jenkins)
" Plug 'sheerun/vim-polyglot'     "all the language packs
Plug 'honza/vim-snippets'       "community snippets for ultisnips
Plug 'kien/ctrlp.vim'           "fuzzy file finder
" Plug 'moll/vim-node'            "gf on a require to open file, and more
Plug 'ruanyl/vim-sort-imports'  "sort imports by module, requires node module import-sort
Plug 'scrooloose/nerdcommenter' ",cc to comment a line
if has('nvim')
  Plug 'mg979/vim-visual-multi'
else
  Plug 'terryma/vim-multiple-cursors'
endif
Plug 'tpope/vim-abolish'        "crs (coerce to snake_case), :Subvert and more
Plug 'tpope/vim-eunuch'         "Unix commands, e.g. :Delete
Plug 'tpope/vim-fugitive'       "git wrapper
Plug 'tpope/vim-obsession'      "save/restore vim sessions
Plug 'tpope/vim-surround'       "change surrounding quotes, parens, xml tags e.g. cs([
Plug 'tpope/vim-vinegar'        "use - to navigate up to folder
Plug 'dense-analysis/ale'       "async lint engine
Plug 'wesQ3/vim-windowswap'     ",ww to swap vim panes
Plug 'tpope/vim-repeat'         "make vim-surround and other plugins work with `.` to repeat
Plug 'tpope/vim-dadbod'         "database client with :DB
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'Quramy/tsuquyomi'         "typescript tsserver client for completion, navigation, etc
Plug 'Quramy/tsuquyomi-vue'
Plug 'simnalamburt/vim-mundo'   "Graphical undo tree with :MundoToggle
Plug 'https://github.com/lifepillar/pgsql.vim.git'
Plug 'goerz/jupytext.vim'
Plug 'isobit/vim-caddyfile'
Plug 'cometsong/CommentFrame.vim'

" Plug 'Shougo/deoplete.nvim'     "autocomplete framework
" Plug 'roxma/nvim-yarp'          "required by deoplete
" Plug 'roxma/vim-hug-neovim-rpc' "required by deoplete
" For func argument completion
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" codoto/tabnine-vim is a fork of youcompleteme
" for some reason it wasn't working when I didn't explicitly specify 'for' (2021-10-21)
" Plug 'codota/tabnine-vim', { 'for': [
  " \'cpp',
  " \'go',
  " \'javascript',
  " \'javascript.jsx',
  " \'python',
  " \'rust',
  " \'sh',
  " \'sql'
  " \'typescript',
  " \'vim',
  " \'vue'
  " \]}
" Plug 'codota/tabnine-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'autozimu/LanguageClient-neovim' "lsp client for intellisenes like behavior
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" On-demand loading
call plug#end()
noremap <F4> :source $MYVIMRC<cr>:PlugInstall<cr>

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
set foldmethod=indent
set foldlevel=99
set pastetoggle=<F2>
set colorcolumn=100
set textwidth=100
set formatoptions=cqj  "c: autwrap comments, q: allow 'gq' format, j: strip comment leader on join
set timeoutlen=500 "Time to wait for a mapped sequence to complete.



" Keep swap files in one of these 
set directory=~/tmp//,~/.tmp//,/var/tmp//,/tmp//,.

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
colorscheme nord
syntax enable

" Minimum window height = 0
set wmh=0

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsListSnippets="<c-tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom-ultisnips"]

" function! CleverTab()
"    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"       return "\<Tab>"
"    else
"       return "\<C-N>"
" endfunction
" 
" function! g:UltiSnips_Complete()
"     call UltiSnips#ExpandSnippet()
"     if g:ulti_expand_res == 0
"       return CleverTab()
"     endif
"     return ""
" endfunction

" au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" 
" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"


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

" Pane/split navigation
noremap gh <C-W>h
noremap gj <C-W>j
noremap gk <C-W>k
noremap gl <C-W>l
noremap g= <C-W>=
noremap g\| <C-W>\|
noremap g< <C-W><
noremap g> <C-W>>
noremap g+ <C-W>+
noremap g- <C-W>-


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
nnoremap <leader>n :cn<return>
nnoremap <leader>8 yiw:Ggrep<space><C-R>"<cr>
vnoremap <C-8> y:Ggrep<space><C-R>"<cr>

" type ,t in normal mode to close open html tags
au FileType html inoremap <buffer> <leader>t </<C-x><C-o>

" swap words with ,s on first word then ,t on second word
" noremap <leader>s "sdiwms
" noremap <leader>t "tdiw"sp`s"tP

" Essentially the oposite of 'J' (join)
noremap <c-J> i<cr><esc>l

" <c-u> in normal mode capitalizes current word
inoremap <c-u> <esc>muviwU`ua

" quickly edit vimrc
nnoremap <leader>ev :vsplit $HOME/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:echo "Sourced .vimrc"<cr>

" diffs
nnoremap <leader>do :diffoff<cr>
nnoremap <leader>dt :diffthis<cr>

" sqlwrap
nnoremap <leader>gs :s/\(from\|where\|and\|group by\|order by\)/\r\1/g<cr>

" Copy to system clipboard
noremap <leader>c :w ! pbcopy<cr><cr>

vnoremap <c-q> <esc>`<i'<esc>`>a'<esc>

au FileType python iabbrev <buffer> ii import ipdb; ipdb.set_trace()

" Currently not using syntastic, using ALE instead
" let g:syntastic_check_on_open = 1
" let g:syntastic_python_checkers = ['pyflakes', 'flake8']
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_typescript_checkers = ['tsuquyomi']
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_auto_loc_list = 0

let g:ctrlp_user_command = ['.git', 'cd %s && cat <(git ls-files) <(git ls-files --others --exclude-standard)']
" let g:ctrlp_user_command = ['.git', 'cd %s && cat git ls-files git ls-files --others --exclude-standard']
let g:ctrlp_match_window = 'max:20,results:100'

set undofile
set undodir=~/.vim/undo/

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

noremap <F3> :redraw!<cr>

au FileType gitcommit set tw=72 colorcolumn=72

highlight ExtraWhitespace ctermbg=235
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
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

"vim-visual-multi setting
let g:VM_no_meta_mappings = 1
"typo fixing
iab opearation operation
iab opeartion operation
iab diamter diameter
iab modle model
iab modles models
iab improt import

"ctags support: look for a .tags file in the current directory
set tags=./.tags

"fixes file watching, see https://webpack.github.io/docs/troubleshooting.html
set backupcopy=yes

"Config for vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.js"
" typing >> in rapid succession will type a single '>', without closetag behavior
inoremap >> >

set nofoldenable

"sort es6 imports, e.g. `import { foo, bar } from 'baz';` becomes `import { bar, foo } from 'baz';`
function! SortImports()
  let line=getline('.')
  let sections=split(line, '[{}]')
  let imports=sort(split(sections[1], ','))
  let newline=sections[0] . "{" . join(imports, ',') . "}" . sections[2]
  call setline('.', newline)
endfunction
nnoremap <leader>sl :call SortImports()<cr>

let g:BASH_CTRL_j = 'off'
noremap <C-k> 10k
noremap <C-j> 10j

"Quickly move to the next quickfix match
noremap <leader>q :cn<cr>
noremap <leader>Q :cN<cr>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" How often to write swapfile to disk, in ms
" This value also affects the responsitveness of the gitgutter plugin
set updatetime=250

noremap g" :s/^\( *\)"\([^"]\+\)"/\1\2/<cr>/kj<cr>

" ALE config (suggestions come from https://flow.org/en/docs/editors/vim/)
let g:ale_statusline_format = ['X %d', '? %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '[%linter%] (%code%) %s'
" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0

" let g:deoplete#enable_at_startup = 1
" " deoplete tab-complete
" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ deoplete#mappings#manual_complete()
" function! s:check_back_space() abort "{{{
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}
" 
" let g:deoplete#file#enable_buffer_path = 1 " Autocomplete files relative to buffer
" 
" function! g:Multiple_cursors_before()
"  " call deoplete#custom#buffer_option('auto_complete', v:false)
" endfunction
" function! g:Multiple_cursors_after()
"  " call deoplete#custom#buffer_option('auto_complete', v:true)
" endfunction

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let g:neosnippet#snippets_directory = "~/.vim/neosnippet"
" 
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" " Enable for deoplete auto-complete profiling
" " call deoplete#custom#option('auto_complete_delay', 200)
" function! StartProfile()
"   call deoplete#custom#option('profile', v:true)
"   call deoplete#enable_logging('DEBUG', 'deoplete.log')
" 	execute ':profile start profile.log'
" 	execute ':profile func *'
" 	execute ':profile file *'
" endfunction

set conceallevel=0

let g:tsuquyomi_disable_quickfix = 1
noremap <F12> :TsuDefinition<cr>
noremap <F2> :TsuRenameSymbol<cr>
noremap <F3> :TsuGeterr<cr>
noremap <F6> :TsuQuickFix<cr>
" NOTE: I wanted to make this c-[, but terminals treat that the same as ESC
noremap <c-\> :TsuReferences<cr>
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>


map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

vnoremap <leader>e :DB $DATABASE_URL<return>
nnoremap <leader>e :DB $DATABASE_URL<return>
nnoremap <leader>r :redraw!<return>

function! Prettier()
  execute ':write'
  execute ':! ./node_modules/.bin/prettier -w %'
endfunction

noremap + :resize +10<return>
noremap = :resize -10<return>

" coc.nvim config https://github.com/neoclide/coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1):
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Default to treating .sql files as pgsql (from https://github.com/lifepillar/pgsql.vim)
let g:sql_type_default = 'pgsql'

autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
" Source is automatically added, you just need to include it in the chain complete list
let g:db = $DATABASE_URL
let g:completion_chain_complete_list = {
    \   'sql': [
    \    {'complete_items': ['vim-dadbod-completion']},
    \   ],
    \ }
" Make sure `substring` is part of this list. Other items are optional for this completion source
let g:completion_matching_strategy_list = ['exact', 'substring']
" Useful if there's a lot of camel case items
let g:completion_matching_ignore_case = 1

" For use in daily activity log
noremap <leader>tt :w<cr>:read !date<cr>A | 

noremap <leader>w vip:DB $DATABASE_URL<return>
