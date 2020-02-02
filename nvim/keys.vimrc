" Change dir for the file we're currently editing
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

nnoremap <Leader><Leader> V

" Easier to select text I just pasted
noremap gV `[v`]

" Visual block instead of visual
nnoremap <Leader>v <C-Q>

" Change split window remapping
noremap <C-J> <C-W>j<CR>
noremap <C-K> <C-W>k<CR>
noremap <C-L> <C-W>l<CR>
noremap <C-H> <C-W>h<CR>

" nnoremap <C-j> <C-d>
" nnoremap <C-k> <C-u>

" Fix built-in terminal mappings
tnoremap <C-n> <C-\><C-n>

" Shortcut for vertical term
nnoremap <silent><leader>o :VTerm<cr>
nnoremap <silent><leader>te :VTerm<cr>

" Abbreviations
iab teh the
iab hte the
iab Teh The
iab fro for
iab Fro For
iab dont don't
iab Dont Don't
iab doesnt doesn't
iab Doesnt Doesn't
iab cant can't
iab Cant Can't
iab lets let's
iab Lets Let's
iab usaeg usage
iab Usaeg Usage
iab atio atoi
iab thred thread
iab thead thread
iab nonde none
iab Nonde None
iab muetex mutex
iab stpo stop
iab STart Start

" For commands
ab vres vertical res
ab vres vertical res
ab vr vertical res
ab vterm VTerm
ab vt VTerm
ab tnew tabnew
ab tn tabnew
