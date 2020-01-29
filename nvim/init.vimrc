call plug#begin('~/.config/nvim/plugged')

" General helpers
Plug 'scrooloose/nerdcommenter'       " Easier Comments
Plug 'atweiden/vim-dragvisuals'       " Drag blocks of code
Plug 'tpope/vim-repeat'               " Easier repeating
Plug 'jiangmiao/auto-pairs'           " Auto closing  closing of quotes, parenthesis, brackets, etc.
Plug 'ntpeters/vim-better-whitespace' " Highlights trailing whitespaces
Plug 'godlygeek/tabular'              " Automatic tabbing
Plug 'tpope/vim-surround'             " Surround help
Plug 'ervandew/supertab'              " Easier tabbing
Plug 'brooth/far.vim'                 " Search and replace


" Ranger integration
Plug 'francoiscabrol/ranger.vim'
" If you use neovim, you have to add the dependency to the plugin bclose.vim
Plug 'rbgrouleff/bclose.vim'

" Better regex
Plug 'tpope/vim-abolish'

" Completion for c and c++
Plug 'zchee/deoplete-clang', {'for': ['c', 'cc', 'cpp', 'h', 'hpp', 'hh']}

" Remembers last cursor position when opening a file
Plug 'dietsche/vim-lastplace'

" File history management
Plug 'sjl/gundo.vim'

" Alias in ex mode
Plug 'vim-scripts/cmdalias.vim'

" Vim misc needed for vim session
Plug 'xolox/vim-misc'

" Session management
" Plug 'xolox/vim-session'

" The matchit.vim script allows you to configure % to match more than just
" single characters.  You can match words and even regular expressions.
" Also, matching treats strings and comments (as recognized by the
" syntax highlighting mechanism) intelligently.
" Plug 'matchit.zip'

" Creates indentation lines
Plug 'yggdroot/indentline'

" This plugin aims at making NERDTree feel like a true panel, independent of tabs.
" Just one NERDTree, always and ever. It will always look the same in all tabs, including expanded/collapsed nodes, scroll position etc.
" Open in all tabs / close in all tabs. Do this via :NERDTreeTabsToggle
" Meaningful tab captions for inactive tabs. No more captions like 'NERD_tree_1'.
" When you close a file, the tab closes with it. No NERDTree hanging open.
" Autoopen NERDTree on GVim / MacVim startup.
" Many of these features can be switched off. See section Configuration.
Plug 'jistr/vim-nerdtree-tabs'

" Used for splitting and creating terminal
" with :new, :VTerm, :2Term, etc
Plug 'mklabs/split-term.vim'

" Tmux
Plug 'christoomey/vim-tmux-navigator'

" Most recent files
Plug 'yegappan/mru'

" Software capslock
Plug 'tpope/vim-capslock'

" Async linting
Plug 'w0rp/ale'

" do commands on selected line
Plug 'vim-scripts/vis'
" Make it easier to use swap files
Plug 'gioele/vim-autoswap'
" Increment dates
Plug 'tpope/vim-speeddating'
" Better looking start-screen
Plug 'mhinz/vim-startify'

" In Vim, pressing ga on a character reveals its representation in decimal, octal, and hex. Characterize.vim modernizes this with the following additions:
" Unicode character names: U+00A9 COPYRIGHT SYMBOL
" Vim digraphs (type after <C-K> to insert the character): Co, cO
" Emoji codes: :copyright:
" HTML entities: &copy;
Plug 'tpope/vim-characterize'

" Snippets and Code completion
" Snippet handler
Plug 'SirVer/ultisnips'
" Extra snippets for ultisnips
Plug 'honza/vim-snippets'

" Variable caching and code completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Colorschemes and themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'

" Git plugin
Plug 'tpope/vim-fugitive'     " Git wrapper for vim
" Plug 'airblade/vim-gitgutter' " Vim diff

" Tree folder viewer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Also file searching but faster
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

" In file searching
Plug 'easymotion/vim-easymotion'

" HTML Plugins
" Write HTML faster
Plug 'rstacruz/sparkup', {'for': ['html']}
" Automatic closing for tags
Plug 'alvan/vim-closetag', {'for': ['html']}
" C++ Plugins
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['cpp', 'cc', 'h', 'hpp']}
" Rust plugins
" Plug 'rust-lang/rust', {'for': ['rs']}

" Add plugins to &runtimepath
call plug#end()
