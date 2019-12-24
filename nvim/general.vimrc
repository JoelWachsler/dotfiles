set clipboard=unnamed " Use computers clipboard instead of VIMs
set number            " Line numbers
set rnu               " Relative line numbers
set hlsearch

" Min number of lines to show above and below the cursor
set scrolloff=1
" set modeline
syntax on
set noautoindent
" I do indentation by myself
set nocindent
set nosmartindent
set showcmd           " Show chars typed when using commands
set tabstop=2         " Render tabs with this many spaces
set shiftwidth=2      " The tab amount for the < and > chars
" Use spaces instead of tabs
set expandtab
set nohlsearch        " Remove highlighting on search
set ignorecase
set magic
set smartcase
set ruler
set cursorline        " Highlight the current line
set cursorcolumn      " Highlight the current column
set gdefault
set incsearch
" Natural splitting
set splitbelow
set splitright
" Improves Vi -> Vim
set nocompatible
" Caused a lot of problems when using fish...
set shell=/bin/bash
" Regex live preview
" Difference between noslit and split?
set inccommand=nosplit

" Set the help height to be fullscreen
set helpheight=100

" Make the previous word uppercase
inoremap <C-F> <Esc>gUiw`]a

" Cursor fix - change cursor when inserting
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

" Treat various flavors of css like normal css
"autocmd BufNewFile,BufRead *.scss set ft=scss.css

set guifont=Menlo:h14
set background=dark
colorscheme onedark

" Backup settings
set undodir=~/.config/nvim/tmp/undo/

" Persistent undo between files
set undofile
set history=100
set undolevels=100

