set nocompatible

set shortmess=I

call plug#begin()
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'alvan/vim-closetag'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
call plug#end()

" Set fzf runtime
set rtp+=/opt/homebrew/opt/fzf

" Enable syntax highlighting
syntax on
filetype plugin indent on

" Colorscheme see https://github.com/hukl/Smyck-Color-Scheme
color smyck

" Add line numbers
set number
set ruler
set cursorline

" Disable Backup and Swap files
set noswapfile
set nobackup
set nowritebackup

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Disable Mode Display because Status line is on
set noshowmode

" Show trailing spaces and highlight hard tabs
set list listchars=tab:»·,trail:·

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Strip trailing whitespaces on each save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Close window if last remaining window is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Search related settings
set incsearch
set hlsearch

" Map Ctrl+l to clear highlighted searches
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> <C-p> :<C-u>Files<CR><C-p>

map <leader>d :ALEGoToDefinition<CR>
map <leader>r :ALEFindReferences<CR>

" Highlight characters behind the 80 chars margin
:au BufWinEnter * let w:m2=matchadd('ColumnMargin', '\%>80v.\+', -1)

" Disable code folding
set nofoldenable

" Always show status bar
set laststatus=2

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>


" Always show ALE Gutter
let g:ale_sign_column_always = 1
let g:ale_elixir_elixir_ls_release = expand("~/src/elixir-ls/rel")

" No bgcolor for ALE SignColumn
highlight clear SignColumn

" ALE Linting Settings
" Erlang linting done via https://github.com/ten0s/syntaxerl
" Download/Build it and put it in your $PATH
let g:ale_linters = {
\   'erlang': ['syntaxerl'],
\   'elixir': ['elixir-ls'],
\   'javascript': ['eslint'],
\}

" Ignorde JS files on CTAGS generation
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore', '*.js', '*.json', '*.css']

" make uses real tabs
au FileType make set noexpandtab

" Ruby uses 2 spaces
au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2

" Go uses tabs
au FileType go set noexpandtab tabstop=4 shiftwidth=4

" Go Foo
let g:go_fmt_command = "goimports"

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
au FileType ruby   set softtabstop=2 tabstop=2 shiftwidth=2


" Gitgutter
set updatetime=250

" lightline / Ale

let g:lightline = {
      \ 'colorscheme': 'smyck'
\}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }


let g:lightline.active = { 'right': [['filetype'],[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <silent> <Leader>f :Rg!<CR>

let s:test_colors = [
    \ '#616e64', '#0d0a79',
    \ '#6d610d', '#0a7373',
    \ '#690d0a', '#6d696e',
    \ '#0d0a6f', '#616e0d',
    \ '#0a6479', '#6d0d0a',
    \ '#617373', '#0d0a69',
    \ '#6d690d', '#0a6e6f',
    \ '#610d0a', '#6e6479',
    \]

let g:terminal_ansi_colors = [
    \ '#616e64', '#0d0a79',
    \ '#6d610d', '#0a7373',
    \ '#690d0a', '#6d696e',
    \ '#0d0a6f', '#616e0d',
    \ '#0a6479', '#6d0d0a',
    \ '#617373', '#0d0a69',
    \ '#6d690d', '#0a6e6f',
    \ '#610d0a', '#6e6479',
    \]
