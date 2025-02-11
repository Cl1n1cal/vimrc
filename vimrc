" Vimrc file
" Niceness
set relativenumber
set nu rnu
set autoindent

" Tabs 
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Leader key
let leader = " "

" Movement
" normal
nnoremap n j
nnoremap t e
nnoremap e k
nnoremap i l
nnoremap s b
" visual
vnoremap n j
vnoremap t e
vnoremap e k
vnoremap i l
vnoremap s b

" Jumping 10 lines
nnoremap <C-n> 10j
nnoremap <C-e> 10k

" Going to last line of file or beginning
nnoremap C G
nnoremap cc gg


" Swapping between modes
nnoremap l i

" File saving and quitting
nnoremap <Space>v :wq<CR>
nnoremap <Space>t :w<CR>
nnoremap <Space>s :q<CR>

" Block cursor
" Set block cursor in insert mode
if &term =~ 'xterm'
  let &t_SI = "\e[2 q"   " Block cursor in insert mode
  let &t_SR = "\e[4 q"   " Underline cursor in replace mode
  let &t_EI = "\e[1 q"   " Block cursor in normal mode
endif

" LSP settings
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
" Suggestions
inoremap <C-x> <C-x><C-o>
" Scroll suggestions down
inoremap <C-n> <C-x><C-o><C-n>
" Scroll suggestions up
inoremap <C-e> <C-p>

if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
