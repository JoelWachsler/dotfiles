" Closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.jsx"

" Airline
let g:airline_powerline_fonts = 1

" Vim-session
let g:session_directory = $HOME."/dotfiles/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"

" Split-Term
let g:disable_key_mappings = 0

" Vim-commentary
nmap <Leader>cc gcc
vmap <Leader>cc gcc

" Nerdtree
let NERDTreeShowHidden=1
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.o$', '\.hex$', '\.elf$', '\.swp$', '\.swo$', '\.DS_Store', '.git']

" Dragvisuals
runtime plugin/dragvisuals.vim

vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1

" Easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Two letter search
nmap s <Plug>(easymotion-s2)

" Easymotion settings
map <C-f> <Plug>(easymotion-sn)
let g:EasyMotion_smartcase = 1  " Case insensitive search

" FZF settings
nnoremap <C-T> :Files<CR>
inoremap <C-T> <ESC>:Files<CR>
nnoremap <C-P> :BTags<cr>
inoremap <C-U> <ESC>:Snippets<CR>
nnoremap <Leader>u :Snippets<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_smart_case = 1

"let g:deoplete#skip_chars = []
autocmd InsertLeave * pclose!
" Close the documentation window when completion is done
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" Numbertoggle
let g:NumberToggleTrigger="<Leader>n"

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = $HOME."/dotfiles/nvim/UltiSnips"
let g:UltiSnipsSnippetDirectories = [$HOME."/dotfiles/nvim/UltiSnips", "UltiSnips"]

" Supertab fix for deoplete
let g:SuperTabDefaultCompletionType = "<tab>"

" Deoplete clang
if has("mac")
  let g:deoplete#sources#clang#libclang_path = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
  let g:deoplete#sources#clang#clang_header	= "/Library/Developer/CommandLineTools/usr/lib"
else
  " Assuming we're not on a mac
  let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
  let g:deoplete#sources#clang#clang_header	= "/usr/lib/"
endif
