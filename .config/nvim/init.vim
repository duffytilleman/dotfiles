let g:coq_settings = { 'auto_start': 'shut-up' }
call plug#begin()
Plug 'folke/lsp-colors.nvim'
Plug 'godlygeek/tabular'                                    " Required for vim-markdown, also use :Tab to align lines
Plug 'preservim/vim-markdown'
Plug 'jose-elias-alvarez/null-ls.nvim'                      " language server helper library required for prettier.nvim
Plug 'mg979/vim-visual-multi'
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " Completions
Plug 'ray-x/lsp_signature.nvim' " function signature completion
Plug 'MunifTanjim/prettier.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'scrooloose/nerdcommenter'                             " ,cc to comment a line
Plug 'simnalamburt/vim-mundo'                               " Graphical undo tree with :MundoToggle
Plug 'https://gitlab.com/madyanov/svart.nvim.git'
Plug 'tpope/vim-abolish'                                    " crs (coerce to snake_case), :Subvert and more
Plug 'tpope/vim-dadbod'                                     " database client with :DB
Plug 'tpope/vim-eunuch'                                     " Unix commands, e.g. :Delete
Plug 'tpope/vim-fugitive'                                   " git wrapper
Plug 'tpope/vim-repeat'                                     " make vim-surround and other plugins work with `.` to repeat
Plug 'tpope/vim-surround'                                   " change surrounding quotes, parens, xml tags e.g. cs([
Plug 'tpope/vim-vinegar'                                    " use - to navigate up to folder
call plug#end()


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

"""""""""""""""""""""""""""""""""""""
" Basic key setup

let mapleader=","
inoremap kj <Esc>

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
lua require('telescope').load_extension('fzf')
" See more in config.lua

"""""""""""""""""""""""""""""""""""""
" Nerdcommenter config
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDDefaultAlign = 'left'

"""""""""""""""""""""""""""""""""""""
" Svart config
"
lua << EOF
vim.keymap.set({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>")        -- begin exact search
vim.keymap.set({ "n", "x", "o" }, "S", "<Cmd>SvartRegex<CR>")   -- begin regex search
vim.keymap.set({ "n", "x", "o" }, "gs", "<Cmd>SvartRepeat<CR>") -- repeat with last accepted query
EOF

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

lua require('config')
