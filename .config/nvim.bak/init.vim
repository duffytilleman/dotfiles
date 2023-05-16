let g:coq_settings = { 'auto_start': 'shut-up' }
call plug#begin()
Plug 'folke/lsp-colors.nvim'
Plug 'godlygeek/tabular'                                    " All the lua functions I don't want to write twice.Required for vim-markdown, also use :Tab to align lines
Plug 'preservim/vim-markdown'
Plug 'hashivim/vim-terraform'
Plug 'jose-elias-alvarez/null-ls.nvim'                      " language server helper library required for prettier.nvim
Plug 'mg979/vim-visual-multi'
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}                   " Completions
Plug 'ray-x/lsp_signature.nvim'                             " function signature completion
Plug 'MunifTanjim/prettier.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'                                " lua vim utility functions, not sure which plugin required this
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }    " ctrl-p fuzzy file finder
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-tree/nvim-web-devicons'
" Plug 'nvim-tree/nvim-tree.lua'                            " File explorer
Plug 'lambdalisue/nerdfont.vim'                             " Nerd font (dependency of fern-renderer-nerdfont)
Plug 'lambdalisue/fern.vim'                                 " File explorer
Plug 'lambdalisue/fern-hijack.vim'                          " Make fern the default file explorer
Plug 'lambdalisue/fern-renderer-nerdfont.vim'               " Icons for fern file explorer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'scrooloose/nerdcommenter'                             " ,cc to comment a line
Plug 'simnalamburt/vim-mundo'                               " Graphical undo tree with :MundoToggle
Plug 'https://gitlab.com/madyanov/svart.nvim.git'           " jump to any location
Plug 'tpope/vim-abolish'                                    " crs (coerce to snake_case), :Subvert and more
Plug 'tpope/vim-dadbod'                                     " database client with :DB
Plug 'tpope/vim-eunuch'                                     " Unix commands, e.g. :Delete
Plug 'tpope/vim-fugitive'                                   " git wrapper
Plug 'tpope/vim-repeat'                                     " make vim-surround and other plugins work with `.` to repeat
Plug 'tpope/vim-surround'                                   " change surrounding quotes, parens, xml tags e.g. cs([
Plug 'tpope/vim-vinegar'                                    " use - to navigate up to folder

Plug 'MunifTanjim/nui.nvim'
Plug 'dpayne/CodeGPT.nvim'
call plug#end()

"""""""""""""""""""""""""""""""""""""
" Basic key setup

let mapleader=","
inoremap kj <Esc>
set pastetoggle=<F2>

" move lines up and down with arrow keys
nnoremap <Down> :m .+1<CR>==
nnoremap <Up> :m .-2<CR>==
inoremap <Down> <Esc>:m .+1<CR>==gi
inoremap <Up> <Esc>:m .-2<CR>==gi
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap <Up> :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""
" Basic config
set foldmethod=indent
set foldlevel=99

"""""""""""""""""""""""""""""""""""""
" LSP setup
:lua require('lspconfig')['tsserver'].setup{}
nnoremap <leader>t <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <C-\> <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<cr>

" Create an empty line underneath without moving the cursor
noremap <expr> <CR> (&buftype is# "quickfix" ? "<CR>" : "mlo<Esc>`l")

" Indent with spacebar
noremap <space> >>
noremap <S-Tab> <<

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

"""""""""""""""""""""""""""""""""""""
" Tabs and Spaces
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start

"""""""""""""""""""""""""""""""""""""
" searching
set ignorecase     " ignore case in search
set smartcase      " override ignorecase if uppercase is used in search string
nnoremap <leader>g :silent Ggrep<space>
nnoremap <leader>n :cnext<return>
nnoremap <leader>p :cprevious<return>
nnoremap <leader>8 yiw:Ggrep<space><C-R>"<cr>

" Open quickfix window automatically after :grep and :Ggrep
autocmd QuickFixCmdPost Ggrep cwindow

"""""""""""""""""""""""""""""""""""""
" Visual look and feel
" colorscheme xoria256
colorscheme nord

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=239
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"""""""""""""""""""""""""""""""""""""
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
noremap + :resize +10<return>
noremap = :resize -10<return>


" diffs
nnoremap <leader>do :diffoff<cr>
nnoremap <leader>dt :diffthis<cr>

"""""""""""""""""""""""""""""""""""""
" quickly edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:echo "Sourced init.vim"<cr>
noremap <F4> :source $MYVIMRC<cr>:PlugInstall<cr>

"""""""""""""""""""""""""""""""""""""
" Persist undo history across restarts
set undofile
set undodir=~/.config/nvim/undo/

"""""""""""""""""""""""""""""""""""""
" Telescope fuzzy finder config
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>
lua require('telescope').load_extension('fzf')
" See more in config.lua

"""""""""""""""""""""""""""""""""""""
" Nerdcommenter config
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDDefaultAlign = 'left'

"""""""""""""""""""""""""""""""""""""
" dadbod database plugin config

" Default to treating .sql files as pgsql (from https://github.com/lifepillar/pgsql.vim)
let g:sql_type_default = 'pgsql'
let g:db = $DATABASE_URL
vnoremap <leader>e :DB $DATABASE_URL<return>
nnoremap <leader>e :DB $DATABASE_URL<return>
noremap <leader>w vip:DB $DATABASE_URL<return>

"""""""""""""""""""""""""""""""""""""
" Duffy workflow shortcut
" noremap <leader>tt :w<cr>:read !date<cr>A | " For use in daily activity log
noremap <leader>c :w ! pbcopy<cr><cr>
noremap <leader>c :w ! pbcopy<cr><cr>
" For use in daily activity log
noremap <leader>tt :w<cr>:read !date<cr>A | 
noremap <leader>tl yypkiconsole.log('A')



"""""""""""""""""""""""""""""""""""""
" Fern file explorer config
let g:fern#renderer = "nerdfont"
let g:fern#disable_default_mappings = 1
function! s:init_fern() abort
  nmap <buffer> <C-C> <Plug>(fern-action-cancel)
  nmap <buffer> <Plug>(fern-action-cd) <Plug>(fern-action-cd:cursor)
  nmap <buffer> a <Plug>(fern-action-choice)
  nmap <buffer> C <Plug>(fern-action-clipboard-copy)
  nmap <buffer> M <Plug>(fern-action-clipboard-move)
  nmap <buffer> P <Plug>(fern-action-clipboard-paste)
  nmap <buffer> h <Plug>(fern-action-collapse)
  nmap <buffer> c <Plug>(fern-action-copy)
  nmap <buffer> <Plug>(fern-action-diff) <Plug>(fern-action-diff:edit)
  nmap <buffer> <Plug>(fern-action-diff:edit) <Plug>(fern-action-diff:edit-or-error)
  nmap <buffer> <Plug>(fern-action-diff:edit:vert) <Plug>(fern-action-diff:edit-or-error:vert
  nmap <buffer> <Plug>(fern-action-diff:vert) <Plug>(fern-action-diff:edit:vert)
  nmap <buffer> fe <Plug>(fern-action-exclude)
  nmap <buffer> <Plug>(fern-action-expand) <Plug>(fern-action-expand:in)
  nmap <buffer> ? <Plug>(fern-action-help)
  nmap <buffer> ! <Plug>(fern-action-hidden)
  nmap <buffer> <Plug>(fern-action-hidden) <Plug>(fern-action-hidden:toggle)
  nmap <buffer> fi <Plug>(fern-action-include)
  nmap <buffer> <Plug>(fern-action-lcd) <Plug>(fern-action-lcd:cursor)
  " nmap <buffer> <BS> <Plug>(fern-action-leave)
  nmap <buffer> - <Plug>(fern-action-leave)
  " nmap <buffer> - <Plug>(fern-action-mark)
  nmap <buffer> <Space> <Plug>(fern-action-mark)
  nmap <buffer> <Plug>(fern-action-mark) <Plug>(fern-action-mark:toggle)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> % <Plug>(fern-action-new-file)
  nmap <buffer> e <Plug>(fern-action-open)
  nmap <buffer> <CR> <Plug>(fern-action-open-or-enter)
  nmap <buffer> l <Plug>(fern-action-open-or-expand)
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:edit)
  nmap <buffer> <Plug>(fern-action-open:edit) <Plug>(fern-action-open:edit-or-error)
  nmap <buffer> s <Plug>(fern-action-open:select)
  nmap <buffer> E <Plug>(fern-action-open:side)
  nmap <buffer> x <Plug>(fern-action-open:system)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> <C-L> <Plug>(fern-action-redraw)
  nmap <buffer> <F5> <Plug>(fern-action-reload)
  nmap <buffer> <Plug>(fern-action-reload) <Plug>(fern-action-reload:all)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> <Plug>(fern-action-rename:edit) <Plug>(fern-action-rename:edit-or-error)
  nmap <buffer> <Plug>(fern-action-rename) <Plug>(fern-action-rename:split)
  nmap <buffer> . <Plug>(fern-action-repeat)
  nmap <buffer> i <Plug>(fern-action-reveal)
  nmap <buffer> <Plug>(fern-action-tcd) <Plug>(fern-action-tcd:cursor)
  nmap <buffer> <Plug>(fern-action-terminal) <Plug>(fern-action-terminal:edit)
  nmap <buffer> <Plug>(fern-action-terminal:edit) <Plug>(fern-action-terminal:edit-or-error)
  nmap <buffer> D <Plug>(fern-action-trash)
  nmap <buffer> y <Plug>(fern-action-yank)
  nmap <buffer> <Plug>(fern-action-yank) <Plug>(fern-action-yank:path)
  nmap <buffer> z <Plug>(fern-action-zoom)
  nmap <buffer> Z <Plug>(fern-action-zoom:reset)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

lua require('config')
